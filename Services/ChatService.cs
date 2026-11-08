using System.Net.Http.Json;
using System.Text;
using System.Text.Json;
using Anthropic;
using Anthropic.Exceptions;
using Anthropic.Models.Beta.Messages;
using DakLakAIGuide.API.Data;
using Microsoft.EntityFrameworkCore;

namespace DakLakAIGuide.API.Services;

public record ChatTurn(string Role, string Content);

public class ChatUnavailableException : Exception
{
    public ChatUnavailableException(string message) : base(message) { }
}

public class ChatService
{
    private const int MaxHistory = 20;
    private const int MaxMessageLength = 2000;

    private readonly ApplicationDbContext _context;
    private readonly IConfiguration _config;
    private readonly ILogger<ChatService> _logger;

    private readonly IHttpClientFactory _httpFactory;

    public ChatService(ApplicationDbContext context, IConfiguration config, ILogger<ChatService> logger,
        IHttpClientFactory httpFactory)
    {
        _context = context;
        _config = config;
        _logger = logger;
        _httpFactory = httpFactory;
    }

    public async Task<string> AskAsync(IReadOnlyList<ChatTurn> history, CancellationToken ct)
    {
        var turns = history
            .Where(t => !string.IsNullOrWhiteSpace(t.Content))
            .TakeLast(MaxHistory)
            .SkipWhile(t => t.Role == "assistant") // tin nhắn đầu tiên phải là của user
            .Select(t => t with
            {
                Role = t.Role == "assistant" ? "assistant" : "user",
                Content = t.Content.Length > MaxMessageLength ? t.Content[..MaxMessageLength] : t.Content
            })
            .ToList();

        if (turns.Count == 0 || turns[^1].Role == "assistant")
            throw new ArgumentException("Cần có câu hỏi của người dùng ở cuối hội thoại.");

        // AI:Provider = "gemini" (mặc định, có gói miễn phí) hoặc "anthropic"
        var provider = (_config["AI:Provider"] ?? "gemini").Trim().ToLowerInvariant();
        return provider == "anthropic"
            ? await AskClaudeAsync(turns, ct)
            : await AskGeminiAsync(turns, ct);
    }

    // ===================== Google Gemini =====================
    private async Task<string> AskGeminiAsync(List<ChatTurn> turns, CancellationToken ct)
    {
        var apiKey = _config["Gemini:ApiKey"];
        if (string.IsNullOrWhiteSpace(apiKey)) apiKey = Environment.GetEnvironmentVariable("GEMINI_API_KEY");
        if (string.IsNullOrWhiteSpace(apiKey))
            throw new ChatUnavailableException("Chatbot chưa được cấu hình (thiếu GEMINI_API_KEY).");

        var model = _config["Gemini:Model"] ?? "gemini-2.5-flash";
        var body = new
        {
            systemInstruction = new { parts = new[] { new { text = await BuildSystemPromptAsync(ct) } } },
            contents = turns.Select(t => new
            {
                role = t.Role == "assistant" ? "model" : "user",
                parts = new[] { new { text = t.Content } }
            }),
            generationConfig = new { maxOutputTokens = 4096, temperature = 0.7 }
        };

        var http = _httpFactory.CreateClient();
        http.Timeout = TimeSpan.FromSeconds(90);
        using var request = new HttpRequestMessage(HttpMethod.Post,
            $"https://generativelanguage.googleapis.com/v1beta/models/{Uri.EscapeDataString(model)}:generateContent")
        {
            Content = JsonContent.Create(body)
        };
        request.Headers.Add("x-goog-api-key", apiKey);

        HttpResponseMessage response;
        try
        {
            response = await http.SendAsync(request, ct);
        }
        catch (HttpRequestException ex)
        {
            _logger.LogError(ex, "Không kết nối được Gemini API");
            throw new ChatUnavailableException("Chatbot tạm thời không phản hồi, vui lòng thử lại sau.");
        }

        using (response)
        {
            var json = await response.Content.ReadAsStringAsync(ct);
            if ((int)response.StatusCode == 429)
                throw new ChatUnavailableException("Chatbot đang quá tải (hết lượt miễn phí), vui lòng thử lại sau ít phút.");
            if (!response.IsSuccessStatusCode)
            {
                _logger.LogError("Gemini API lỗi {Status}: {Body}", (int)response.StatusCode, json);
                throw new ChatUnavailableException("Chatbot tạm thời không phản hồi, vui lòng thử lại sau.");
            }

            using var doc = JsonDocument.Parse(json);
            var sb = new StringBuilder();
            if (doc.RootElement.TryGetProperty("candidates", out var candidates) && candidates.GetArrayLength() > 0
                && candidates[0].TryGetProperty("content", out var content)
                && content.TryGetProperty("parts", out var parts))
            {
                foreach (var part in parts.EnumerateArray())
                {
                    // Bỏ qua phần "suy nghĩ" nội bộ của model nếu có
                    if (part.TryGetProperty("thought", out var thought) && thought.ValueKind == JsonValueKind.True) continue;
                    if (part.TryGetProperty("text", out var text)) sb.Append(text.GetString());
                }
            }

            var reply = sb.ToString().Trim();
            return reply.Length > 0
                ? reply
                : "Xin lỗi, mình không thể trả lời câu hỏi này. Bạn có thể hỏi về du lịch, văn hóa hoặc đặc sản Đắk Lắk nhé!";
        }
    }

    // ===================== Anthropic Claude =====================
    private async Task<string> AskClaudeAsync(List<ChatTurn> turns, CancellationToken ct)
    {
        var apiKey = _config["Anthropic:ApiKey"];
        if (string.IsNullOrWhiteSpace(apiKey)) apiKey = Environment.GetEnvironmentVariable("ANTHROPIC_API_KEY");
        if (string.IsNullOrWhiteSpace(apiKey))
            throw new ChatUnavailableException("Chatbot chưa được cấu hình (thiếu ANTHROPIC_API_KEY).");

        var messages = new List<BetaMessageParam>();
        foreach (var t in turns)
        {
            if (t.Role == "assistant")
                messages.Add(new BetaAssistantMessageParam { Content = t.Content });
            else
                messages.Add(new BetaUserMessageParam { Content = t.Content });
        }

        var client = new AnthropicClient { ApiKey = apiKey };

        var parameters = new MessageCreateParams
        {
            Model = _config["Anthropic:Model"] ?? "claude-opus-5-5",
            MaxTokens = 4096,
            System = await BuildSystemPromptAsync(ct),
            Messages = messages,
            OutputConfig = new BetaOutputConfig { Effort = Effort.Low },
            // Nếu model chính từ chối (bộ lọc an toàn), API tự chạy lại bằng model dự phòng
            Betas = ["server-side-fallback-2026-07-01"],
            Fallbacks = new Default(),
        };

        try
        {
            var response = await client.Beta.Messages.Create(parameters, ct);

            if (response.StopReason == BetaStopReason.Refusal)
                return "Xin lỗi, mình không thể trả lời câu hỏi này. Bạn có thể hỏi về du lịch, văn hóa hoặc đặc sản Đắk Lắk nhé!";

            var sb = new StringBuilder();
            foreach (var block in response.Content)
            {
                if (block.TryPickText(out var text))
                    sb.Append(text.Text);
            }
            return sb.ToString().Trim();
        }
        catch (AnthropicRateLimitException)
        {
            throw new ChatUnavailableException("Chatbot đang quá tải, vui lòng thử lại sau ít phút.");
        }
        catch (AnthropicApiException ex)
        {
            _logger.LogError(ex, "Lỗi gọi Claude API");
            throw new ChatUnavailableException("Chatbot tạm thời không phản hồi, vui lòng thử lại sau.");
        }
    }

    // Đưa dữ liệu trong database vào ngữ cảnh để AI trả lời đúng thông tin của tỉnh
    private async Task<string> BuildSystemPromptAsync(CancellationToken ct)
    {
        var places = await _context.TouristPlaces.AsNoTracking()
            .Include(p => p.Category)
            .OrderBy(p => p.PlaceId)
            .ToListAsync(ct);
        var products = await _context.OcopProducts.AsNoTracking()
            .Include(p => p.Category)
            .OrderBy(p => p.ProductId)
            .ToListAsync(ct);
        var articles = await _context.CulturalArticles.AsNoTracking()
            .Include(a => a.Category)
            .OrderBy(a => a.ArticleId)
            .ToListAsync(ct);

        var sb = new StringBuilder();
        sb.AppendLine("""
            Bạn là "DakLak AI Guide", trợ lý du lịch thân thiện của tỉnh Đắk Lắk (Việt Nam).
            Bạn giúp du khách tìm hiểu địa điểm du lịch, văn hóa Tây Nguyên và sản phẩm OCOP của Đắk Lắk.

            Cách trả lời:
            - Trả lời bằng tiếng Việt (hoặc bằng ngôn ngữ người dùng đang dùng), ngắn gọn, dễ hiểu.
            - Ưu tiên dùng dữ liệu trong mục DỮ LIỆU bên dưới; nêu cụ thể tên, địa chỉ, giá vé, giờ mở cửa khi có.
            - Nếu dữ liệu không có thông tin, có thể dùng hiểu biết chung nhưng nói rõ là thông tin tham khảo
              và khuyên du khách kiểm tra lại. Không bịa giá, số điện thoại hay địa chỉ.
            - Có thể gợi ý lịch trình, món ăn, quà mang về dựa trên dữ liệu.
            - Nếu câu hỏi không liên quan tới du lịch/văn hóa/đặc sản, lịch sự hướng người dùng quay lại chủ đề.
            - Có thể dùng Markdown đơn giản (gạch đầu dòng, in đậm).
            """);

        sb.AppendLine("\n=== DỮ LIỆU: ĐỊA ĐIỂM DU LỊCH ===");
        foreach (var p in places)
        {
            sb.Append($"- [{p.PlaceId}] {p.Name}");
            if (p.Category?.CategoryName is { } c) sb.Append($" | Loại: {c}");
            if (!string.IsNullOrWhiteSpace(p.Address)) sb.Append($" | Địa chỉ: {p.Address}");
            if (p.TicketPrice is { } t) sb.Append($" | Giá vé: {t:N0}đ");
            if (!string.IsNullOrWhiteSpace(p.OpenTime)) sb.Append($" | Giờ: {p.OpenTime}-{p.CloseTime}");
            if (p.IsFeatured) sb.Append(" | Nổi bật");
            if (!string.IsNullOrWhiteSpace(p.Description)) sb.Append($" | Mô tả: {Short(p.Description, 400)}");
            sb.AppendLine();
        }

        sb.AppendLine("\n=== DỮ LIỆU: SẢN PHẨM OCOP ===");
        foreach (var p in products)
        {
            sb.Append($"- [{p.ProductId}] {p.Name}");
            if (p.Category?.CategoryName is { } c) sb.Append($" | Loại: {c}");
            if (p.OcopLevel is { } l) sb.Append($" | OCOP {l} sao");
            if (!string.IsNullOrWhiteSpace(p.Producer)) sb.Append($" | Nhà sản xuất: {p.Producer}");
            if (p.Price is { } pr) sb.Append($" | Giá: {pr:N0}đ");
            if (!string.IsNullOrWhiteSpace(p.Address)) sb.Append($" | Địa chỉ: {p.Address}");
            if (!string.IsNullOrWhiteSpace(p.Description)) sb.Append($" | Mô tả: {Short(p.Description, 300)}");
            sb.AppendLine();
        }

        sb.AppendLine("\n=== DỮ LIỆU: VĂN HÓA ===");
        foreach (var a in articles)
        {
            sb.Append($"- [{a.ArticleId}] {a.Title}");
            if (a.Category?.CategoryName is { } c) sb.Append($" | Chủ đề: {c}");
            if (!string.IsNullOrWhiteSpace(a.Content)) sb.Append($" | Nội dung: {Short(a.Content, 600)}");
            sb.AppendLine();
        }

        var foods = await _context.Foods.AsNoTracking().OrderBy(f => f.FoodId).ToListAsync(ct);
        sb.AppendLine("\n=== DỮ LIỆU: ẨM THỰC ===");
        foreach (var f in foods)
        {
            sb.Append($"- [{f.FoodId}] {f.Name}");
            if (!string.IsNullOrWhiteSpace(f.FoodType)) sb.Append($" | Loại: {f.FoodType}");
            if (!string.IsNullOrWhiteSpace(f.PriceRange)) sb.Append($" | Giá: {f.PriceRange}");
            if (!string.IsNullOrWhiteSpace(f.WhereToEat)) sb.Append($" | Ăn ở đâu: {Short(f.WhereToEat, 200)}");
            if (!string.IsNullOrWhiteSpace(f.Address)) sb.Append($" | Địa chỉ: {f.Address}");
            if (!string.IsNullOrWhiteSpace(f.Description)) sb.Append($" | Mô tả: {Short(f.Description, 300)}");
            sb.AppendLine();
        }

        var events = await _context.Events.AsNoTracking().OrderBy(e => e.StartDate).ToListAsync(ct);
        sb.AppendLine($"\n=== DỮ LIỆU: LỄ HỘI & SỰ KIỆN (hôm nay là {DateTime.UtcNow.AddHours(7):dd/MM/yyyy}) ===");
        foreach (var e in events)
        {
            sb.Append($"- [{e.EventId}] {e.Name}");
            if (e.StartDate is { } s) sb.Append($" | Từ {s:dd/MM/yyyy}");
            if (e.EndDate is { } en) sb.Append($" đến {en:dd/MM/yyyy}");
            if (!string.IsNullOrWhiteSpace(e.TimeNote)) sb.Append($" | Thời gian: {e.TimeNote}");
            if (!string.IsNullOrWhiteSpace(e.Location)) sb.Append($" | Địa điểm: {e.Location}");
            if (!string.IsNullOrWhiteSpace(e.Description)) sb.Append($" | Mô tả: {Short(e.Description, 300)}");
            sb.AppendLine();
        }

        return sb.ToString();
    }

    private static string Short(string s, int max)
    {
        s = s.ReplaceLineEndings(" ");
        return s.Length <= max ? s : s[..max] + "…";
    }
}

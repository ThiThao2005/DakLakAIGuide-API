using DakLakAIGuide.API.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;

namespace DakLakAIGuide.API.Controllers;

public record ChatRequest(List<ChatTurn> Messages);

[Route("api/chat")]
[ApiController]
public class ChatController : ControllerBase
{
    private readonly ChatService _chat;

    public ChatController(ChatService chat)
    {
        _chat = chat;
    }

    [HttpPost]
    [EnableRateLimiting("chat")]
    public async Task<IActionResult> Ask(ChatRequest request, CancellationToken ct)
    {
        if (request.Messages is null || request.Messages.Count == 0)
            return BadRequest(new { message = "Vui lòng nhập câu hỏi" });

        try
        {
            var reply = await _chat.AskAsync(request.Messages, ct);
            return Ok(new { reply });
        }
        catch (ArgumentException ex)
        {
            return BadRequest(new { message = ex.Message });
        }
        catch (ChatUnavailableException ex)
        {
            return StatusCode(503, new { message = ex.Message });
        }
    }
}

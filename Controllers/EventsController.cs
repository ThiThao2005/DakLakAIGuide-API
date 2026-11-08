using DakLakAIGuide.API.Data;
using DakLakAIGuide.API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DakLakAIGuide.API.Controllers;

[Route("api/events")]
[ApiController]
public class EventsController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public EventsController(ApplicationDbContext context)
    {
        _context = context;
    }

    // GET /api/events            → tất cả (sắp diễn ra trước, rồi chưa có lịch, rồi đã qua)
    // GET /api/events?upcoming=true → chỉ sự kiện chưa kết thúc hoặc chưa có ngày
    [HttpGet]
    public async Task<IActionResult> GetEvents([FromQuery] bool upcoming = false)
    {
        var today = DateOnly.FromDateTime(DateTime.UtcNow.AddHours(7)); // giờ Việt Nam
        var events = await _context.Events.AsNoTracking().ToListAsync();

        DateOnly? LastDay(TourismEvent e) => e.EndDate ?? e.StartDate;
        bool IsPast(TourismEvent e) => LastDay(e) is { } d && d < today;

        var result = events
            .Where(e => !upcoming || !IsPast(e))
            // Nhóm: 0 = sắp/đang diễn ra, 1 = chưa có ngày, 2 = đã qua
            .OrderBy(e => IsPast(e) ? 2 : e.StartDate is null && e.EndDate is null ? 1 : 0)
            // Sắp diễn ra: gần nhất trước; đã qua: mới nhất trước
            .ThenBy(e => IsPast(e)
                ? -LastDay(e)!.Value.DayNumber
                : (e.StartDate ?? e.EndDate)?.DayNumber ?? 0)
            .ThenByDescending(e => e.IsFeatured)
            .ThenBy(e => e.Name)
            .ToList();

        return Ok(result);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetEvent(int id)
    {
        var item = await _context.Events.FindAsync(id);
        if (item == null)
            return NotFound(new { message = "Không tìm thấy sự kiện" });
        return Ok(item);
    }

    [Authorize]
    [HttpPost]
    public async Task<IActionResult> CreateEvent(TourismEvent item)
    {
        if (item.StartDate is { } s && item.EndDate is { } e && e < s)
            return BadRequest(new { message = "Ngày kết thúc phải sau ngày bắt đầu" });

        item.EventId = 0;
        item.CreatedAt = DateTime.UtcNow;
        _context.Events.Add(item);
        await _context.SaveChangesAsync();
        return CreatedAtAction(nameof(GetEvent), new { id = item.EventId }, item);
    }

    [Authorize]
    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateEvent(int id, TourismEvent item)
    {
        var existing = await _context.Events.FindAsync(id);
        if (existing == null)
            return NotFound(new { message = "Không tìm thấy sự kiện" });
        if (item.StartDate is { } s && item.EndDate is { } e && e < s)
            return BadRequest(new { message = "Ngày kết thúc phải sau ngày bắt đầu" });

        existing.Name = item.Name;
        existing.Description = item.Description;
        existing.StartDate = item.StartDate;
        existing.EndDate = item.EndDate;
        existing.TimeNote = item.TimeNote;
        existing.Location = item.Location;
        existing.Latitude = item.Latitude;
        existing.Longitude = item.Longitude;
        existing.ImageUrl = item.ImageUrl;
        existing.Website = item.Website;
        existing.IsFeatured = item.IsFeatured;

        await _context.SaveChangesAsync();
        return Ok(existing);
    }

    [Authorize]
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteEvent(int id)
    {
        var item = await _context.Events.FindAsync(id);
        if (item == null)
            return NotFound(new { message = "Không tìm thấy sự kiện" });

        _context.Events.Remove(item);
        await _context.SaveChangesAsync();
        return NoContent();
    }
}

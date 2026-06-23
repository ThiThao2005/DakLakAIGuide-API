using DakLakAIGuide.API.Data;
using DakLakAIGuide.API.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DakLakAIGuide.API.Controllers;

[Route("api/[controller]")]
[ApiController]
public class PlacesController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public PlacesController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetPlaces()
    {
        var places = await _context.TouristPlaces
            .Include(p => p.Category)
            .OrderByDescending(p => p.IsFeatured)
            .ThenBy(p => p.Name)
            .ToListAsync();

        return Ok(places);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetPlace(int id)
    {
        var place = await _context.TouristPlaces
            .Include(p => p.Category)
            .FirstOrDefaultAsync(p => p.PlaceId == id);

        if (place == null)
            return NotFound(new { message = "Không tìm thấy địa điểm" });

        return Ok(place);
    }

    [HttpPost]
    public async Task<IActionResult> CreatePlace(TouristPlace place)
    {
        place.CreatedAt = DateTime.UtcNow;

        _context.TouristPlaces.Add(place);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetPlace), new { id = place.PlaceId }, place);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdatePlace(int id, TouristPlace place)
    {
        var existing = await _context.TouristPlaces.FindAsync(id);

        if (existing == null)
            return NotFound(new { message = "Không tìm thấy địa điểm" });

        existing.Name = place.Name;
        existing.Description = place.Description;
        existing.CategoryId = place.CategoryId;
        existing.Address = place.Address;
        existing.Latitude = place.Latitude;
        existing.Longitude = place.Longitude;
        existing.TicketPrice = place.TicketPrice;
        existing.OpenTime = place.OpenTime;
        existing.CloseTime = place.CloseTime;
        existing.ImageUrl = place.ImageUrl;
        existing.Website = place.Website;
        existing.IsFeatured = place.IsFeatured;

        await _context.SaveChangesAsync();

        return Ok(existing);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeletePlace(int id)
    {
        var place = await _context.TouristPlaces.FindAsync(id);

        if (place == null)
            return NotFound(new { message = "Không tìm thấy địa điểm" });

        _context.TouristPlaces.Remove(place);
        await _context.SaveChangesAsync();

        return Ok(new { message = "Xóa địa điểm thành công" });
    }
}
using DakLakAIGuide.API.Data;
using DakLakAIGuide.API.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DakLakAIGuide.API.Controllers;

[Route("api/foods")]
[ApiController]
public class FoodsController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public FoodsController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetFoods() =>
        Ok(await _context.Foods.AsNoTracking()
            .OrderByDescending(f => f.IsFeatured)
            .ThenBy(f => f.Name)
            .ToListAsync());

    [HttpGet("{id}")]
    public async Task<IActionResult> GetFood(int id)
    {
        var item = await _context.Foods.FindAsync(id);
        if (item == null)
            return NotFound(new { message = "Không tìm thấy món ăn" });
        return Ok(item);
    }

    [Authorize]
    [HttpPost]
    public async Task<IActionResult> CreateFood(Food item)
    {
        item.FoodId = 0;
        item.CreatedAt = DateTime.UtcNow;
        _context.Foods.Add(item);
        await _context.SaveChangesAsync();
        return CreatedAtAction(nameof(GetFood), new { id = item.FoodId }, item);
    }

    [Authorize]
    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateFood(int id, Food item)
    {
        var existing = await _context.Foods.FindAsync(id);
        if (existing == null)
            return NotFound(new { message = "Không tìm thấy món ăn" });

        existing.Name = item.Name;
        existing.Description = item.Description;
        existing.FoodType = item.FoodType;
        existing.PriceRange = item.PriceRange;
        existing.WhereToEat = item.WhereToEat;
        existing.Address = item.Address;
        existing.Latitude = item.Latitude;
        existing.Longitude = item.Longitude;
        existing.ImageUrl = item.ImageUrl;
        existing.IsFeatured = item.IsFeatured;

        await _context.SaveChangesAsync();
        return Ok(existing);
    }

    [Authorize]
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteFood(int id)
    {
        var item = await _context.Foods.FindAsync(id);
        if (item == null)
            return NotFound(new { message = "Không tìm thấy món ăn" });

        _context.Foods.Remove(item);
        await _context.SaveChangesAsync();
        return NoContent();
    }
}

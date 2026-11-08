using DakLakAIGuide.API.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DakLakAIGuide.API.Controllers;

[Route("api/categories")]
[ApiController]
public class CategoriesController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public CategoriesController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet("places")]
    public async Task<IActionResult> GetPlaceCategories() =>
        Ok(await _context.PlaceCategories
            .OrderBy(c => c.CategoryName)
            .Select(c => new { c.CategoryId, c.CategoryName })
            .ToListAsync());

    [HttpGet("ocop")]
    public async Task<IActionResult> GetOcopCategories() =>
        Ok(await _context.OcopCategories
            .OrderBy(c => c.CategoryName)
            .Select(c => new { c.CategoryId, c.CategoryName })
            .ToListAsync());

    [HttpGet("culture")]
    public async Task<IActionResult> GetCultureCategories() =>
        Ok(await _context.CulturalCategories
            .OrderBy(c => c.CategoryName)
            .Select(c => new { c.CategoryId, c.CategoryName })
            .ToListAsync());
}

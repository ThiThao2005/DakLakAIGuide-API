using DakLakAIGuide.API.Data;
using DakLakAIGuide.API.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DakLakAIGuide.API.Controllers;

[Route("api/ocop")]
[ApiController]
public class OcopProductsController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public OcopProductsController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetProducts()
    {
        var products = await _context.OcopProducts
            .Include(p => p.Category)
            .OrderByDescending(p => p.OcopLevel)
            .ThenBy(p => p.Name)
            .ToListAsync();

        return Ok(products);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetProduct(int id)
    {
        var product = await _context.OcopProducts
            .Include(p => p.Category)
            .FirstOrDefaultAsync(p => p.ProductId == id);

        if (product == null)
            return NotFound(new { message = "Không tìm thấy sản phẩm OCOP" });

        return Ok(product);
    }

    [HttpPost]
    public async Task<IActionResult> CreateProduct(OcopProduct product)
    {
        product.CreatedAt = DateTime.UtcNow;

        _context.OcopProducts.Add(product);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetProduct), new { id = product.ProductId }, product);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateProduct(int id, OcopProduct product)
    {
        var existing = await _context.OcopProducts.FindAsync(id);

        if (existing == null)
            return NotFound(new { message = "Không tìm thấy sản phẩm OCOP" });

        existing.Name = product.Name;
        existing.Description = product.Description;
        existing.CategoryId = product.CategoryId;
        existing.Producer = product.Producer;
        existing.OcopLevel = product.OcopLevel;
        existing.Price = product.Price;
        existing.Address = product.Address;
        existing.Latitude = product.Latitude;
        existing.Longitude = product.Longitude;
        existing.Website = product.Website;
        existing.ImageUrl = product.ImageUrl;

        await _context.SaveChangesAsync();

        return Ok(existing);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteProduct(int id)
    {
        var product = await _context.OcopProducts.FindAsync(id);

        if (product == null)
            return NotFound(new { message = "Không tìm thấy sản phẩm OCOP" });

        _context.OcopProducts.Remove(product);
        await _context.SaveChangesAsync();

        return Ok(new { message = "Xóa sản phẩm OCOP thành công" });
    }
}
using DakLakAIGuide.API.Data;
using DakLakAIGuide.API.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DakLakAIGuide.API.Controllers;

[Route("api/culture")]
[ApiController]
public class CultureController : ControllerBase
{
    private readonly ApplicationDbContext _context;

    public CultureController(ApplicationDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetArticles()
    {
        var articles = await _context.CulturalArticles
            .Include(a => a.Category)
            .OrderByDescending(a => a.CreatedAt)
            .ToListAsync();

        return Ok(articles);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetArticle(int id)
    {
        var article = await _context.CulturalArticles
            .Include(a => a.Category)
            .FirstOrDefaultAsync(a => a.ArticleId == id);

        if (article == null)
            return NotFound(new { message = "Không tìm thấy bài viết văn hóa" });

        return Ok(article);
    }

    [HttpPost]
    public async Task<IActionResult> CreateArticle(CulturalArticle article)
    {
        article.CreatedAt = DateTime.UtcNow;

        _context.CulturalArticles.Add(article);
        await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(GetArticle), new { id = article.ArticleId }, article);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateArticle(int id, CulturalArticle article)
    {
        var existing = await _context.CulturalArticles.FindAsync(id);

        if (existing == null)
            return NotFound(new { message = "Không tìm thấy bài viết văn hóa" });

        existing.Title = article.Title;
        existing.Content = article.Content;
        existing.CategoryId = article.CategoryId;
        existing.ImageUrl = article.ImageUrl;

        await _context.SaveChangesAsync();

        return Ok(existing);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteArticle(int id)
    {
        var article = await _context.CulturalArticles.FindAsync(id);

        if (article == null)
            return NotFound(new { message = "Không tìm thấy bài viết văn hóa" });

        _context.CulturalArticles.Remove(article);
        await _context.SaveChangesAsync();

        return Ok(new { message = "Xóa bài viết văn hóa thành công" });
    }
}
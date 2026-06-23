using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DakLakAIGuide.API.Models;

[Table("culturalarticles")]
public class CulturalArticle
{
    [Key]
    [Column("articleid")]
    public int ArticleId { get; set; }

    [Column("title")]
    public string Title { get; set; } = string.Empty;

    [Column("content")]
    public string? Content { get; set; }

    [Column("categoryid")]
    public int? CategoryId { get; set; }

    [Column("imageurl")]
    public string? ImageUrl { get; set; }

    [Column("createdat")]
    public DateTime? CreatedAt { get; set; }

    public CulturalCategory? Category { get; set; }
}
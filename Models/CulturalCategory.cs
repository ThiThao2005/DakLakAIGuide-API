using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DakLakAIGuide.API.Models;

[Table("culturalcategories")]
public class CulturalCategory
{
    [Key]
    [Column("categoryid")]
    public int CategoryId { get; set; }

    [Column("categoryname")]
    public string? CategoryName { get; set; }

    public ICollection<CulturalArticle>? CulturalArticles { get; set; }
}
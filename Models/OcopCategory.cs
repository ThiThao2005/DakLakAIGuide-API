using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DakLakAIGuide.API.Models;

[Table("ocopcategories")]
public class OcopCategory
{
    [Key]
    [Column("categoryid")]
    public int CategoryId { get; set; }

    [Column("categoryname")]
    public string? CategoryName { get; set; }

    public ICollection<OcopProduct>? OcopProducts { get; set; }
}
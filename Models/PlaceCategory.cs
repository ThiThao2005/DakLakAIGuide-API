using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DakLakAIGuide.API.Models;

[Table("placecategories")]
public class PlaceCategory
{
    [Key]
    [Column("categoryid")]
    public int CategoryId { get; set; }

    [Column("categoryname")]
    public string? CategoryName { get; set; }

    public ICollection<TouristPlace>? TouristPlaces { get; set; }
}
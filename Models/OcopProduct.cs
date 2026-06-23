using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DakLakAIGuide.API.Models;

[Table("ocopproducts")]
public class OcopProduct
{
    [Key]
    [Column("productid")]
    public int ProductId { get; set; }

    [Column("name")]
    public string Name { get; set; } = string.Empty;

    [Column("description")]
    public string? Description { get; set; }

    [Column("categoryid")]
    public int? CategoryId { get; set; }

    [Column("producer")]
    public string? Producer { get; set; }

    [Column("ocoplevel")]
    public int? OcopLevel { get; set; }

    [Column("price")]
    public decimal? Price { get; set; }

    [Column("address")]
    public string? Address { get; set; }

    [Column("latitude")]
    public decimal? Latitude { get; set; }

    [Column("longitude")]
    public decimal? Longitude { get; set; }

    [Column("website")]
    public string? Website { get; set; }

    [Column("imageurl")]
    public string? ImageUrl { get; set; }

    [Column("createdat")]
    public DateTime? CreatedAt { get; set; }

    public OcopCategory? Category { get; set; }
}
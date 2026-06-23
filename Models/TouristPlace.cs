using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DakLakAIGuide.API.Models;

[Table("touristplaces")]
public class TouristPlace
{
    [Key]
    [Column("placeid")]
    public int PlaceId { get; set; }

    [Column("name")]
    public string Name { get; set; } = string.Empty;

    [Column("description")]
    public string? Description { get; set; }

    [Column("categoryid")]
    public int? CategoryId { get; set; }

    [Column("address")]
    public string? Address { get; set; }

    [Column("latitude")]
    public decimal? Latitude { get; set; }

    [Column("longitude")]
    public decimal? Longitude { get; set; }

    [Column("ticketprice")]
    public decimal? TicketPrice { get; set; }

    [Column("opentime")]
    public string? OpenTime { get; set; }

    [Column("closetime")]
    public string? CloseTime { get; set; }

    [Column("imageurl")]
    public string? ImageUrl { get; set; }

    [Column("website")]
    public string? Website { get; set; }

    [Column("isfeatured")]
    public bool IsFeatured { get; set; }

    [Column("createdat")]
    public DateTime? CreatedAt { get; set; }

    public PlaceCategory? Category { get; set; }
}
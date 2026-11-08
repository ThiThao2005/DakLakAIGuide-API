using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DakLakAIGuide.API.Models;

[Table("events")]
public class TourismEvent
{
    [Key]
    [Column("eventid")]
    public int EventId { get; set; }

    [Column("name")]
    public string Name { get; set; } = string.Empty;

    [Column("description")]
    public string? Description { get; set; }

    [Column("startdate")]
    public DateOnly? StartDate { get; set; }

    [Column("enddate")]
    public DateOnly? EndDate { get; set; }

    // Mô tả thời gian khi chưa có ngày cụ thể, ví dụ "Tháng 3, hai năm một lần"
    [Column("timenote")]
    public string? TimeNote { get; set; }

    [Column("location")]
    public string? Location { get; set; }

    [Column("latitude")]
    public decimal? Latitude { get; set; }

    [Column("longitude")]
    public decimal? Longitude { get; set; }

    [Column("imageurl")]
    public string? ImageUrl { get; set; }

    [Column("website")]
    public string? Website { get; set; }

    [Column("isfeatured")]
    public bool IsFeatured { get; set; }

    [Column("createdat")]
    public DateTime? CreatedAt { get; set; }
}

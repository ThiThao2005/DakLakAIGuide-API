using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DakLakAIGuide.API.Models;

[Table("foods")]
public class Food
{
    [Key]
    [Column("foodid")]
    public int FoodId { get; set; }

    [Column("name")]
    public string Name { get; set; } = string.Empty;

    [Column("description")]
    public string? Description { get; set; }

    // Loại món: Món chính, Món ăn vặt, Đồ uống...
    [Column("foodtype")]
    public string? FoodType { get; set; }

    // Khoảng giá tham khảo, ví dụ "30.000đ – 50.000đ"
    [Column("pricerange")]
    public string? PriceRange { get; set; }

    // Quán/khu vực gợi ý để thưởng thức
    [Column("wheretoeat")]
    public string? WhereToEat { get; set; }

    [Column("address")]
    public string? Address { get; set; }

    [Column("latitude")]
    public decimal? Latitude { get; set; }

    [Column("longitude")]
    public decimal? Longitude { get; set; }

    [Column("imageurl")]
    public string? ImageUrl { get; set; }

    [Column("isfeatured")]
    public bool IsFeatured { get; set; }

    [Column("createdat")]
    public DateTime? CreatedAt { get; set; }
}

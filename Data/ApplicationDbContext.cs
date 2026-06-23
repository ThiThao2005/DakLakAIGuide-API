using DakLakAIGuide.API.Models;
using Microsoft.EntityFrameworkCore;

namespace DakLakAIGuide.API.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<TouristPlace> TouristPlaces => Set<TouristPlace>();
    public DbSet<PlaceCategory> PlaceCategories => Set<PlaceCategory>();

    public DbSet<OcopProduct> OcopProducts => Set<OcopProduct>();
    public DbSet<OcopCategory> OcopCategories => Set<OcopCategory>();

    public DbSet<CulturalArticle> CulturalArticles => Set<CulturalArticle>();
    public DbSet<CulturalCategory> CulturalCategories => Set<CulturalCategory>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<TouristPlace>()
            .HasOne(p => p.Category)
            .WithMany(c => c.TouristPlaces)
            .HasForeignKey(p => p.CategoryId);

        modelBuilder.Entity<OcopProduct>()
            .HasOne(p => p.Category)
            .WithMany(c => c.OcopProducts)
            .HasForeignKey(p => p.CategoryId);

        modelBuilder.Entity<CulturalArticle>()
            .HasOne(a => a.Category)
            .WithMany(c => c.CulturalArticles)
            .HasForeignKey(a => a.CategoryId);
    }
}
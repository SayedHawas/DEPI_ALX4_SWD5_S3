using Microsoft.EntityFrameworkCore;

namespace ASPCoreWebAPIDemos.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext()
        {

        }
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Product> Products { get; set; }

        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    optionsBuilder.UseSqlServer("Data Source=SAYEDHAWAS\\SWD5GS3;Initial Catalog=WebAPIDB;Integrated Security=True;Trust Server Certificate=True");
        //}
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //base.OnModelCreating(modelBuilder);
            //modelBuilder.Entity<Category>(entity =>
            //{
            //    entity.HasKey(e => e.Id);
            //    entity.Property(e => e.Name).IsRequired().HasMaxLength(50);
            //    entity.Property(e => e.Description).HasMaxLength(200);
            //});
            //Seeding initial data
            modelBuilder.Entity<Category>().HasData(
                new Category { Id = 1, Name = "Electronics", Description = "Electronic gadgets and devices" },
                new Category { Id = 2, Name = "Books", Description = "All kinds of books" },
                new Category { Id = 3, Name = "Clothing", Description = null }
            );
        }
    }
}

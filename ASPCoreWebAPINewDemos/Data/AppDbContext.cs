namespace ASPCoreWebAPINewDemos.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext()
        {

        }
        public AppDbContext(DbContextOptions options) : base(options)
        {

        }

        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Product> Products { get; set; }

        //override protected void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    optionsBuilder.UseSqlServer(@"Data Source=SAYEDHAWAS\SWD5GS3;Initial Catalog=WebAPI2DB;Integrated Security=True;Trust Server Certificate=True");
        //}

        override protected void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            //seed data for categories
            modelBuilder.Entity<Category>().HasData(
                new Category { CategoryId = 1, Name = "Phones", Description = "Devices and gadgets" },
                new Category { CategoryId = 2, Name = "Books", Description = "All kinds of books" },
                new Category { CategoryId = 3, Name = "Clothing", Description = "Apparel and accessories" }
            );
            //Fluent Api(Using code C#)
            //modelBuilder.Entity<Category>(s =>
            //{
            //    s.HasKey(x => x.Id);  // Primary Key
            //    s.Property(x => x.Id).ValueGeneratedNever(); // Not Identity 
            //    s.Property(x => x.Name).IsRequired().HasMaxLength(100); // Name is required and has max length of 100
            //});
        }
    }
}

namespace MVCProjectDemo.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext()
        {

        }
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }
        //protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        //{
        //    //base.OnConfiguring(optionsBuilder);
        //    optionsBuilder.UseSqlServer("Server=localhost;Database=EmployeeDB;Trusted_Connection=True;TrustServerCertificate=True;");
        //}

        public DbSet<Category> Categories { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Product> Products { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            //fluent API configurations = Data Annotations

            //seed data
            modelBuilder.Entity<Models.Category>().HasData(
                new Models.Category { Id = 1, Name = "Electronics" },
                new Models.Category { Id = 2, Name = "Clothing" },
                new Models.Category { Id = 3, Name = "Books" });

            modelBuilder.Entity<Models.User>().HasData(
                new Models.User
                {
                    Id = 1,
                    Username = "admin",
                    Password = "admin123",
                    Email = "Admin@gmail.com"
                });

            modelBuilder.Entity<Models.Category>()
                .Property(e => e.Name)
                .IsRequired().HasMaxLength(100);
        }
    }
}
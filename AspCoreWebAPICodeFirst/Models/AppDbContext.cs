using Microsoft.EntityFrameworkCore;

namespace AspCoreWebAPICodeFirst.Models
{
    public class AppDbContext : DbContext
    {
        public virtual DbSet<Student> Students { get; set; }

        //Configuration of the database connection string
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseSqlServer("Server=SAYEDHAWAS\\SWD5GS3;Database=CodeFirstDB;Integrated Security=True;Trust Server Certificate=True");
        }
        //ModelCreate method to configure the model and relationships
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // base.OnModelCreating(modelBuilder);
            //Seed Data
            modelBuilder.Entity<Student>().HasData(
                new Student { Id = 1, Name = "Sayed Hawas", Age = 30, Email = "SayedHawas@gmail.com" },
                new Student { Id = 2, Name = "John Doe", Age = 25, Email = "email1@gmail.com" },
                new Student { Id = 3, Name = "Jane Smith", Age = 28, Email = "email1@gmail.com" }
            );

            //modelBuilder.Entity<Student>(entity =>
            //{
            //    entity.HasKey(e => e.Id); // Set Id as the primary key
            //    entity.Property(e => e.Name).IsRequired().HasMaxLength(100); // Configure Name property
            //    entity.Property(e => e.Email).IsRequired().HasMaxLength(100); // Configure Email property
            //    entity.Property(e => e.Age).IsRequired(false); // Configure Age property as optional
            //    entity.Property(e => e.DateOfBirth).IsRequired(false); // Configure DateOfBirth property as optional
            //});
        }
        //Code First Approch to create the database and tables
        //-----------------------------------------------------
        //1) Convention over configuration(With ID)
        //    is a software design principle where frameworks and systems provide sensible default settings
        //2) Data Annotation(Using Attributes).
        //3) Fluent Api(Using code C#).
    }
}

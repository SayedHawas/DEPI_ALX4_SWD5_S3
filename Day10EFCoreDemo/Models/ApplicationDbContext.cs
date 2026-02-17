using Microsoft.EntityFrameworkCore;

namespace Day10EFCoreDemo.Models
{
    public class ApplicationDbContext : DbContext   // Inherit from DbContext class
    {

        //Entity Set (DbSet) for Employees table

        public DbSet<Employee> Employees { get; set; }  // This will create a table named "Employees" in the database

        //Override OnConfiguring method to configure the database connection
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseSqlServer("Data Source=SAYEDHAWAS\\SWD5GS3;Initial Catalog=Day10EFCoreDemoDB;Integrated Security=True;Trust Server Certificate=True"); // Use SQL Server as the database provider

            /* string connectionString = "Data source = SAYEDHAWAS\\SWD5GS3 ; database = Day10EFCoreDemoDB ; Integrated Security = true ; trust server certificate = true";
              Data source     | server  = SAYEDHAWAS\\SWD5GS3 ;
              Initial Catalog |database = Day10EFCoreDemoDB ;
              Integrated Security = true;
              trust server certificate = true;
             */
        }
    }
}

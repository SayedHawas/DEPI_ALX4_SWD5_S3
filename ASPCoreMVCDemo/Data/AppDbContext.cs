using ASPCoreMVCDemo.Models;
using Microsoft.EntityFrameworkCore;

namespace ASPCoreMVCDemo.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext()
        {

        }
        public AppDbContext(DbContextOptions options) : base(options)
        {
            //Provider Using SQL Server
            //Connection string 
        }

        public DbSet<Category> Categories { get; set; }
        public DbSet<Product> Products { get; set; }


    }
}

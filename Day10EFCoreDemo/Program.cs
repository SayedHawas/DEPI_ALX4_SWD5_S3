using Day10EFCoreDemo.Models;

namespace Day10EFCoreDemo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World! Entity framework Core ");
            #region RF Core Demo Code First 
            //1- Add 3 Nn-get Package 
            // package Microsoft.EntityFrameworkCore              DbContext  ConnectionString
            // package Microsoft.EntityFrameworkCore.SqlServer    Provider for SQL Server
            // package Microsoft.EntityFrameworkCore.Tools        Migration Tools

            //2- Create Folder Models
            //3- Create Class for ApplicationDbContext   :  DbContext
            //4- Configure Connection String in OnConfiguring method
            //     - SQl Provider UseSqlServer 
            //     - ConnectionString
            //5- Code First Approach
            //     - Create Class for Entity (Table) Employee 
            //     - Add Properties for Employee Class (Id, Name, Salary,...)
            //     - Data Annotation
            //6- Build Class DbSet into DbContext Class (public DbSet<Employee> Employees { get; set; })  --> Create Table in DB
            //
            //7- Migration Commands  PMC
            //   Add Migration (Add-Migration InitialCreate)  --> Create Migration Folder + InitialCreate.cs
            //   Update-database (Update-Database)  --> Create Database + Create Table in DB

            //8-CRUD 
            //Create Object ApplicationDboContext
            //using (ApplicationDbContext db = new ApplicationDbContext())
            //{
            //    //Create Employee Object
            //    var NewEmployee = new Employee() { Name = "Ahmed Ali ", Job = "Dev", Salary = 20000, Address = "alex", Email = "ahmed@gmail.com", DateOfBirth = new DateTime(2000, 1, 1) };
            //    db.Employees.Add(NewEmployee);
            //    if (db.SaveChanges() > 0) //Commit the changes to the database
            //    {
            //        Console.WriteLine("Employee Added Successfully");
            //    }
            //}

            //Read All
            //using (ApplicationDbContext db = new ApplicationDbContext())
            //{
            //    Console.WriteLine(" ----------------- All Employees -----------------");
            //    var emps = db.Employees.ToList();
            //    foreach (var item in emps)
            //    {
            //        Console.WriteLine(item.ToString());
            //    }

            //    Console.WriteLine(" -----------------  Employees Salary>17000 -----------------");
            //    var emps1 = db.Employees.Where(e => e.Salary > 17000).ToList();
            //    foreach (var item1 in emps1)
            //    {
            //        Console.WriteLine(item1.ToString());
            //    }
            //    // Read By Id
            //    Console.WriteLine(" -----------------  Employees By Id 2 -----------------");
            //    var emp = db.Employees.First(id => id.EmployeeId == 2);
            //    Console.WriteLine(emp.ToString());
            //    Console.WriteLine(" -----------------  Employees By Id 3 -----------------");
            //    var emp1 = db.Employees.Find(3);
            //    Console.WriteLine(emp1.ToString());
            //    Console.WriteLine(" -----------------  Employees By Id 2 -----------------");
            //    var emp2 = db.Employees.FirstOrDefault(id => id.EmployeeId == 20);
            //    Console.WriteLine(emp2 == null ? "NotFound" : emp2.ToString());
            //    Console.WriteLine(" -----------------  Employees By Id 3 -----------------");
            //    //var emp3 = db.Employees.Last(id => id.EmployeeId == 3);
            //    //Console.WriteLine(emp3.ToString());
            //    Console.WriteLine(" -----------------  Employees By Id 3 -----------------");
            //    //var emp4 = db.Employees.LastOrDefault(id => id.EmployeeId == 3);
            //    //Console.WriteLine(emp4.ToString());
            //    Console.WriteLine(" -----------------  Employees By Id 1 -----------------");
            //    var emp5 = db.Employees.Single(id => id.EmployeeId == 1); //Null , Duplicated 
            //    Console.WriteLine(emp5.ToString());
            //    Console.WriteLine(" -----------------  Employees By Id 1 -----------------");
            //    var emp6 = db.Employees.SingleOrDefault(id => id.EmployeeId == 1); //Duplicated 
            //    Console.WriteLine(emp6.ToString());
            //    /*
            //       Find

            //     */
            //}

            ApplicationDbContext db = new ApplicationDbContext();
            // Update 
            //var empUpdate = db.Employees.Find(2);
            //if (empUpdate != null)
            //{
            //    empUpdate.Salary = 25000;
            //    empUpdate.Name = "Mariem";
            //    empUpdate.Job = "Dr";
            //    empUpdate.Address = "Cairo";
            //    empUpdate.Email = "mariem@gamil.com";


            //    db.SaveChanges();
            //    Console.WriteLine("Employee Updated Successfully");
            //}
            //else
            //{
            //    Console.WriteLine("Employee No Found .... ");
            //}
            //Where 

            //Delete 
            var empDelete = db.Employees.Find(3);
            if (empDelete != null)
            {
                db.Employees.Remove(empDelete);
                db.SaveChanges();
                Console.WriteLine("Employee Deleted Successfully");
            }
            else
            {
                Console.WriteLine("Employee No Found .... ");
            }
            Console.ReadLine();

            #endregion
        }
    }
}

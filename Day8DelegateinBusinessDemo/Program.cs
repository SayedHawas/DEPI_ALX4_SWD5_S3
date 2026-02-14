using Day8DLLDemo;

namespace Day8DelegateinBusinessDemo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");

            List<Employee> ListEmployees = new List<Employee>();
            ListEmployees.Add(new Employee { ID = 1, Name = "Retaj", Job = "Developer", Salary = 5000, Attend = true });
            ListEmployees.Add(new Employee { ID = 2, Name = "Mariam", Job = "Dr", Salary = 6000, Attend = true });
            ListEmployees.Add(new Employee { ID = 3, Name = "sayed", Job = "Developer", Salary = 3000, Attend = false });
            ListEmployees.Add(new Employee { ID = 4, Name = "osama", Job = "eng", Salary = 7000, Attend = true });


            Employee.Report(ListEmployees, emp => emp.Attend == true);
            Console.WriteLine("------------------------------------");
            Employee.Report(ListEmployees, x => x.ID > 2);
            Console.WriteLine("------------------------------------");
            Employee.Report(ListEmployees, m => m.Salary > 6000);
            Console.WriteLine("------------------------------------");
            Employee.Report(ListEmployees, q => q.Name.Contains("s"));
            Console.ReadLine();
        }
        //public static bool check(Employee employee)
        //{
        //    // return employee.Attend == true;
        //    return employee.ID > 3;
        //}
    }
}

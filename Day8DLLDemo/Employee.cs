namespace Day8DLLDemo
{
    //Type can be datatype 
    public delegate bool CheckEmployee(Employee employee);
    public class Employee
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Job { get; set; }
        public double Salary { get; set; }
        public bool Attend { get; set; }

        public static void Report(List<Employee> employeeList, CheckEmployee check)
        {
            foreach (Employee emp in employeeList)
            {
                //Hard code
                //if (emp.Salary > 4000)
                if (check(emp))
                {
                    Console.WriteLine($"the Id {emp.ID} name {emp.Name} salary {emp.Salary} job {emp.Job}");
                }

            }
        }
    }
}

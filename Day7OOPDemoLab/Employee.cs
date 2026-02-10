namespace Day7OOPDemoLab
{
    public class Employee : Human, IOperation, ISendEmail
    {
        //Static member                                    0 1 2 3 4
        public static List<int> Numbers = new List<int>() { 1, 2, 3, 4, 5 };
        //Numbers[2] Index

        private static List<Employee> employees = new List<Employee>()
        {
            new Employee() { Id = 1, Name = "Ahmed", Code = 101, Job = "Developer" },
            new Employee() { Id = 2, Name = "tame", Code = 101, Job = "Developer" },
            new Employee() { Id = 3, Name = "ali", Code = 101, Job = "Developer" },
            new Employee() { Id = 4, Name = "Mohamed", Code = 101, Job = "Developer" }
        };

        //Employee emp = new Employee() { Id = 1, Name = "Ahmed", Code = 101, Job = "Developer" };

        //Field
        private int code = 1;
        //Auto Property
        public string Job { get; set; } = "Developer";
        //Property Full
        public int Code
        {
            get { return code; }
            set { code = value; }
        }

        public static List<Employee> Employees { get => employees; set => employees = value; }

        //default - Constructor
        public Employee()
        {
            //Employees.Add(emp);
            // new Employee() { Id = 1, Name = "Ahmed", Code = 101, Job = "Developer" };
        }
        //Overload
        public Employee(int code, string job)
        {
            this.code = code;
            this.Job = job;
        }
        //Method 
        public void Work()
        {

        }
        public override string SayHello()
        {
            return "Welcome .... ";
        }
        public void Save(Employee emp)
        {
            Employees.Add(emp);
        }
        public void Update(int id, Employee NewEmp)
        {
            int x = 100;
            int y = 100;
            bool result = x == y;
            //int x = 5;
            //x = 10;
            //Employee selectEmployee = NewEmp;
            //Mapping 
            Employee selectEmployee = employees[id];
            selectEmployee.Name = NewEmp.Name;
            selectEmployee.Code = NewEmp.Code;
            selectEmployee.Job = NewEmp.Job;
        }
        public void Delete(int id)
        {
            employees.RemoveAt(id);
        }
        public void SendEmail(string email)
        {
            throw new NotImplementedException();
        }
        public override string ToString()
        {
            return $"ID {Id} Name {Name} Code {Code} Job {Job}";  //base.ToString();
        }
        public void GetAll()
        {
            Console.WriteLine(" ----------------- Read All Employee --------------- ");
            foreach (Employee e in Employee.Employees)
            {
                Console.WriteLine(e.ToString());
            }
        }
    }
}

namespace Day5OOPDemoLab
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!   OOP");
            #region Day 5 OOP Session Part 1
            /*
            1 - Object & Class           Done
            2 - Inheritance
            3 - Polymorphism             Done OverLoading
            4 - Encapsulation            Property Full - Auto (hidden Fields) | hidden Data DLL
            5 - Abstraction
            */

            // User Create Type Class --> Object 
            // Class --> Blueprint
            // Object --> Instance of Class
            // Class Member  --> Fields + Properties + Methods
            /*
             Class Members
            ***************    
            Fields        (Variables )                      Done 
            Methods                                         Done 
            Create Object From Class                        Done
            Constructor    ---    
            A constructor is a special kind of method that is automatically run when an object is first created
            
            Constructor Types Default|Non-Default |Static   Done
            Method OverLoad                                 Done
            Constructor OverLoad                            Done
            
            this Keyword                                    Done

            Encapsulation
            Property Full (hidden Fields)                   Done     
            Property ReadOnly (hidden Fields)               Done          
            Property WriteOnly (hidden Fields)              Done

            Property Auto                                   Done              

            Readonly Vs Const Vs Static member              Done

            Readonly   Assign By Constructor Only   Access from Object Reference Only   Done
            Const      Assign By Declaration Only   Access From Class Name Only
            static     Assign By Declaration Only   Access From Class Name Only         Done

            Static Read Only --> Access Assign Static Constructor                       Done
           
            Inheritance   OverView                                                      Done
            : Base Class | Super Class | Parent Class             Done 
              Derived Class | Sub Class | Child Class             Done
             
             
             
            */

            //Create Object From Class

            Console.WriteLine(Employee._tax);
            Employee test;

            Employee ahmed = new Employee();

            //Employee e;



            Console.WriteLine(Employee.EmployeeCount);
            //Access Class Members
            //ahmed.SetId(101); //Add 
            //Console.WriteLine(ahmed.GetId()); //retrieve

            ahmed.Id = 101; //Property Full Encapsulation
            Console.WriteLine(ahmed.Id);


            ahmed.Id = 101;
            ahmed.Name = "Ahmed Ali";
            ahmed.Age = 25;
            ahmed.Salary = 20000;
            ahmed.JobTitle = "Software Developer";
            ahmed.department = "Software";
            ahmed.Password = "123456";

            //ahmed.ApplicationName = "Software";
            Console.WriteLine(ahmed.ApplicationName);
            //Console.WriteLine(ahmed.Password);
            Console.WriteLine(Employee._tax);
            ahmed.GetEmployeeInfo();

            Employee aya = new Employee();
            Console.WriteLine(Employee.EmployeeCount);
            aya.Id = 102;
            aya.Name = "Aya Mohamed";
            aya.Age = 26;
            aya.Salary = 25000;
            aya.JobTitle = "Senior Software Developer";
            aya.department = "Software";
            aya.Password = "123456";
            Console.WriteLine(aya.BackAccountNumber);
            Console.WriteLine(ahmed.ApplicationName);
            aya.GetEmployeeInfo();

            //Using Non-Default Constructor
            //Employee.EmployeeCount = 200;
            Employee sayed = new Employee(103, "Sayed Hassan", 30, 30000, "Team Leader", "software");
            Console.WriteLine(Employee.EmployeeCount);
            Console.WriteLine(ahmed.ApplicationName);
            sayed.Password = "222";
            sayed.GetEmployeeInfo();



            Console.WriteLine(Employee._tax);

            Console.WriteLine("--------------------------------------------------------");
            //Create Class from Manager Class 
            Manager tamer = new Manager(105, "Tamer", 35, 40000, "Project Manager", "IT");
            tamer.ManagerTask = "Manage Project";
            tamer.GetManagerInfo();

            #endregion
            Console.ReadLine();
        }
    }

    // Access Modifiers {Public | Private} class <ClassName>
    //Create Class 
    public class Employee
    {
        //Readonly Vs Const Vs Static member

        public static int EmployeeCount = 0; //Static Field

        public const double _tax = .1; //Const Field
        private readonly string _BackAccountNumber; //Readonly Field

        private string _ApplicationName = "HR Management System"; // Field
        //Class Members
        // Fields (Variables) Must Be Private 
        private int _id; // Field
        private string _name; // Field
        private double _salary; // Field
        private int _age; // Field
        private string _jobTitle; // Field
        private string Department;// Field
        private string _company;
        private string _password = "0123456"; //Default Value;

        //propFull 
        //Prop

        //CTOR
        // Constructors
        // Default Constructor
        public Employee()
        {
            _BackAccountNumber = "0235245";
            Console.WriteLine("Create Instance From Employee Class ...");
            EmployeeCount++; //Increment Employee Count When Create Object From Class
        }
        // Non-Default Constructor - Constructor Overload Polymorphism
        public Employee(int id, string name, int age, double salary, string jobTitle, string Department) //= "software")
        {
            _id = id;
            _name = name;
            _age = age;
            _salary = salary;
            _jobTitle = jobTitle;
            this.Department = Department;
            _BackAccountNumber = "0235245";
            EmployeeCount++;
        }
        static Employee()
        {
            EmployeeCount++;
        }

        //Encapsulation
        //Setter Id Field
        //public void SetId(int id)
        //{
        //    _id = id;
        //}
        ////Getter Id Field
        //public int GetId()
        //{
        //    return _id;
        //}
        //Property Full Encapsulation
        //Property
        public int Id
        {
            //setter
            set { _id = value; }
            //getter
            get { return _id; }
        }
        public string Name
        {
            set { _name = value; }
            get { return _name; }
        }
        public int Age
        {
            set { _age = value; }
            get { return _age; }
        }
        public string JobTitle
        {
            set { _jobTitle = value; }
            get { return _jobTitle; }
        }
        public string department
        {
            set { Department = value; }
            get { return Department; }
        }
        public double Salary
        {
            set
            {
                //Logical into Setter
                if (value < 0)
                {
                    Console.WriteLine("Salary cannot be negative.");
                    _salary = 0;
                }
                else if (value < 5000)
                {
                    Console.WriteLine("Salary cannot be less than 5000.");
                    _salary = 5000;
                }
                else
                    _salary = value;
            }
            get
            {
                _salary = _salary - (_salary * .1); // 10% Tax
                return _salary;
            }
        }
        public string Company
        {
            get { return _company; }
            set { _company = value; }
        }
        //Read Only Property
        public string ApplicationName
        {
            get { return _ApplicationName; }
            //set { _ApplicationName = value; } 
        }
        //Write Only Property
        public string Password
        {
            //get => _password;
            set { _password = value; }
        }
        //Auto Property  --> default Value 
        public string MobileNumber { get; set; } = "01000000000"; //Default Value
        // Read Only Auto Property Field Readonly
        public string BackAccountNumber { get { return _BackAccountNumber; } }


        // Methods
        public void GetEmployeeInfo()
        {
            Console.WriteLine($"ID: {Id}, Name: {Name}, Age: {Age}, Salary: {Salary} , JobTitle : {JobTitle} Department {Department}");
        }
        //Method Overload Polymorphism
        public void GetEmployeeInfo(int id)
        {
            //Modify Read Only Field
            //_BackAccountNumber = "0235245";
            Department = "Finance";
            Console.WriteLine($"ID: {Id}, Name: {Name}, Age: {Age}, Salary: {Salary} , JobTitle : {JobTitle} Department {Department}");
        }

        public double NetSalary()
        {
            double netSalary = Salary - (Salary * _tax);
            return netSalary;
        }
        public double NetSalary(double overtime)
        {
            double netSalary = Salary - (Salary * _tax) + overtime;
            return netSalary;
        }
        public double NetSalary(double overtime, double discount)
        {
            double netSalary = Salary - (Salary * _tax) + overtime - discount;
            return netSalary;
        }
    }
    // Manager m = new Manager();
    public class Manager : Employee   //Super Class | Base Class | Parent Class <-- Base
    {
        public Manager()
        {

        }
        public Manager(int id, string name, int age, double salary, string jobTitle, string Department)
            : base(id, name, age, salary, jobTitle, Department)
        {
            //this.Id = id;
            //this.Name = name;
            //this.Age = age;
            //this.Salary = salary;
            //this.JobTitle = jobTitle;
            //this.department = Department;
        }
        public string ManagerTask { get; set; }

        public void GetManagerInfo()
        {
            Console.WriteLine($"ID: {Id}, Name: {Name}, Age: {Age}, Salary: {Salary} , JobTitle : {JobTitle} Department {department} Manager Task : {ManagerTask}");
        }
    }
}

/*
 *.DLL
 * namespace Block Of Code 
 * Class
 * Method 
 NameSpace 
            --> Classes 
                       --> Methods 
 */

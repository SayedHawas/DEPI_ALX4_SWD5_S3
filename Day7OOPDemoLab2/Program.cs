using Day7OOPDLL;

namespace Day7OOPDemoLab2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");

            #region Day 7 OOP Session Part 2 

            //int y = 200;
            //Int32 x = new Int32();
            //x = 100;
            //String str = new String([ 'A', 'm', 'H' ]);



            Console.WriteLine("------------------ Class ------------------------");
            Employee emp = new Employee();
            emp.Id = 10;
            Employee emp2 = emp;
            Console.WriteLine("Emp " + emp.Id);
            emp2.Id = 100;

            Console.WriteLine("Emp " + emp.Id);
            Console.WriteLine("Emp2 " + emp2.Id);

            Employee emp3 = null;
            Console.WriteLine("------------------ Struct------------------------");
            Point p = new Point();
            p.Id = 10;
            Console.WriteLine("P " + p.Id);
            Point p2 = p;
            p2.Id = 100;
            Console.WriteLine("P " + p.Id);
            Console.WriteLine("P2 " + p2.Id);
            //Point p3 = null;
            // ------------------------------------------------

            MyHelper Mh = new MyHelper();
            Mh.Save();

            MyHelper mh = new MyHelper();




            //    https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers
            //        (public ,private ,protected,internal,protected internal, private protected ,file)	
            //public: Code in any assembly can access this type or member.The accessibility level of the containing type controls the accessibility level of public members of the type.
            //private: Only code declared in the same class or struct can access this member.
            //protected: Only code in the same class or in a derived class can access this type or member.
            //internal: Only code in the same assembly can access this type or member.
            //protected internal: Only code in the same assembly or in a derived class in another assembly can access this type or member.
            //private protected: Only code in the same assembly and in the same class or a derived class can access the type or member.
            //file: Only code in the same file can access the type or member.
            #endregion
            Console.ReadLine();
        }
    }
    //Referance Type  heap  Allow Null
    public class Employee : test
    {
        public int Id { get; set; }

        public void NetSalary(EmployeeTypes employeeTypes)
        {

            //DataBaseProvider.MSSQL

            DayOfWeek dayOfWeek = DayOfWeek.Sunday;

            if (employeeTypes == EmployeeTypes.FullTime)
            {

            }
            switch (employeeTypes)
            {
                case EmployeeTypes.FullTime:
                    break;
                case EmployeeTypes.PartTime:
                    break;
                case EmployeeTypes.Freelance:
                    break;
                case EmployeeTypes.PerProject:
                    break;
                default:
                    break;
            }
        }

    }
    //Value Type   Stack  Not Allow Null  | Not Allow Inheritance
    public struct Point  //: MyBase
    {
        public Point()
        {

        }
        public int Id { get; set; }
        public int x { get; set; }
        public int y { get; set; }
    }

    public class test
    {

    }
    public struct MyBase
    {

    }

    //Enum 
    //Type Can Be DataType 
    public enum EmployeeTypes
    {
        FullTime = 1,
        PartTime,
        Freelance,
        PerProject
    }
    public enum DataBaseProvider
    {
        MSSQL,
        MySQL,
        LietSQL,
        Access

    }
    public class Demo : MyClass
    {
        public Demo()
        {
            //Object
            MyClass mc = new MyClass();
            mc.InternalValue = 10;
            mc.InternalProtectedValue = 20;

            //Inherit

            InternalValue = 10;
            ProtectedValue = 20;
            InternalProtectedValue = 20;
            PrivateProtectedValue = 30;
        }
    }

    public class MyClass                                          //Object     Inherit
    {
        private int PrivateValue { get; set; }                      // X         X
        public int PublicValue { get; set; }                        // O         O
        internal int InternalValue { get; set; }                    // O         O
        protected int ProtectedValue { get; set; }                  // X         O
        internal protected int InternalProtectedValue { get; set; } // O  X      O  O
        private protected int PrivateProtectedValue { get; set; }   // X  X      X  O
    }

    public class test2 : MyHelper
    {
        public test2()
        {
            ProtectedValue = 100;
            InternalProtectedValue = 20;

            MyHelper m = new MyHelper();

        }
    }

}

namespace Day6OOPDemoLab
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");

            #region Review 
            //What operator is used in C# for left bitwise shifting?
            int x = 5;// In binary: 0000 0101
            Console.WriteLine($"Original Number {x} ");
            Console.WriteLine($"Binary {Convert.ToString(x, 2).PadLeft(8, '0')} ");

            int total = x + 5;

            int result = x << 1;
            Console.WriteLine($"Original result {result} ");
            Console.WriteLine($"Binary {Convert.ToString(result, 2).PadLeft(8, '0')} ");

            #endregion
            #region Session OOP Day 6 
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
             
            // 3 - Polymorphism                  OverLoading     Done
            //Polymorphism( OverLoad ,Override + Inheritance)    Done

            // Operator  IS A  --> Check Inheritance Relation Between Types

               Types Of Class  (Reference Type)                
               ***************             InheritanceFrom     InheritanceTo                  Object
               Normal Class                     Done                 Done                      Done    
               Sealed Class                     Done                  X                        Done                          
               Static Class Not Using this       X                    X                         X
               Partial Class                    Done                 Done                      Done                                          
               Abstract Class 0-100 %           Done                 Done (Must Implemented)    X               
               Interface    100%                Done (Interface)     Done (Must Implemented)    X                     
               [Inner]Internal Class            Done                 Done                     Done (With Full Path OuterClass.InnerClass)
               Generic Class <T>                Done 
                    - Generic Field             Done
                    - Generic Method            Done
                    - Generic Parameters        Done
                    - Generic Property          Done


             Extension Method                   Done 

             *** Type Can be DataType *** 
             */
            //Array
            //Generic Collection   List<int>  ,List<string>

            List<int> Numbers = new List<int>() { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
            //LINQ To Object 
            var list = Numbers.Where(n => n % 2 == 0).ToList();



            //Console.WriteLine("------------ Employee -----------");
            //Employee emp1 = new Employee();
            //emp1.Id = 1;
            //emp1.Name = "Ahmed";
            //emp1.Job = "Developer";
            //emp1.Salary = 10000;
            //emp1.Department = "Software";
            //emp1.NetSalary(.1, 1000);
            //emp1.Task();
            //Console.WriteLine(emp1.ToString());
            //if (emp1 is Developer)
            //{
            //    Console.WriteLine($"True Dv1 is {emp1.GetType()} ....");
            //}
            //else
            //{
            //    Console.WriteLine($"False Dv1 is {emp1.GetType()} ....");
            //}

            //Console.WriteLine("---------------- Developer --------------- ");
            //Developer dv1 = new Developer();
            //dv1.Id = 2;
            //dv1.Name = "Mariem";
            //dv1.Job = "Full Stack  Developer";
            //dv1.Salary = 25000;
            //dv1.Department = "Software";
            //dv1.NetSalary(0.1, 1000);
            //dv1.ProgrammingLanguage = "C#";
            //dv1.Task();
            //Console.WriteLine(dv1.ToString());
            //if (dv1 is Developer)
            //{
            //    Console.WriteLine($" True Dv1 is {dv1.GetType()} ....");
            //}
            //else
            //{
            //    Console.WriteLine($" False Dv1 is {dv1.GetType()} ....");
            //}

            //Console.WriteLine("---------------- Manager --------------- ");
            //Manager Mag1 = new Manager();
            //Mag1.Id = 3;
            //Mag1.Name = "Ali";
            //Mag1.Job = "Manager Software";
            //Mag1.Salary = 50000;
            //Mag1.Department = "Software";
            //Mag1.ProgrammingLanguage = "C#";
            //Mag1.Meeting = "Agile Meeting";
            //Mag1.NetSalary(0.1, 1000, 5000);
            //Mag1.Task();
            //Console.WriteLine(Mag1.ToString());
            //if (Mag1 is Developer)
            //{
            //    Console.WriteLine($" True Dv1 is {Mag1.GetType()} ....");
            //}
            //else
            //{
            //    Console.WriteLine($" False Dv1 is {Mag1.GetType()} ....");
            //}


            //Console.WriteLine("---------------- CEO --------------- ");
            //CEO Osama = new CEO();
            //Osama.Id = 4;
            //Osama.Name = "Osama";
            //Osama.Job = "Company CEO";
            //Osama.Salary = 100000;
            //Osama.Department = "Management";
            //Osama.Meeting = "Top Level Meeting";
            //Osama.NetSalary(0.1, 1000, 5000);
            //Osama.Task();
            //Console.WriteLine(Osama.ToString());

            //----------------------------  Class Types -------------------------------------
            //
            NormalClass Nc = new NormalClass();
            Nc.Id = 1;
            //Static Member Access From Class Name Only
            NormalClass.SendEmail();


            SealedClass sc = new SealedClass();
            sc.Code = 100;

            //StaticClass sca = new StaticClass();

            StaticClass.CompanyName = "ITI";
            StaticClass.ShowCompany();

            //Open & Close Principle Open Extend Class By Inheritance Or Extension Method Not Modify Code Of Class
            int n = 5;
            Console.WriteLine(n.Add(10));
            Console.WriteLine(n.CheckOdd());
            n = 10;
            Console.WriteLine(n.CheckOdd());

            Console.WriteLine(ExtensionClass.Add(10, 20));
            int myCode = 300;
            Console.WriteLine(myCode.Add(50));


            PartialClass PC = new PartialClass();
            PC.Id = 100;

            //AbstractClass AC = new AbstractClass();
            //AC.Save();

            OuterClass Oc = new OuterClass();
            Oc.Id = 100;

            OuterClass.InnerClass Ic = new OuterClass.InnerClass();
            Ic.Id = 200;

            //  Generic Class<T>
            IntLMyList mylist = new IntLMyList(5);  //0,1,2,3,4
            Console.WriteLine(mylist.ListLength);
            mylist.Add(100);    //0
            mylist.Add(200);    //1
            mylist.Add(300);    //2
            mylist.Add(400);    //3
            mylist.Add(500);    //4

            //mylist.Add(600);    //5  Error
            Console.WriteLine("----------- Read By For ----------");
            for (int i = 0; i < mylist.ListLength; i++)
            {
                //mylist[i]
                Console.WriteLine(mylist.GetValue(i));
            }



            GenericMyList<int> listInt = new GenericMyList<int>(5);  //0,1,2,3,4
            Console.WriteLine(mylist.ListLength);
            listInt.Add(100);    //0
            listInt.Add(200);    //1
            listInt.Add(300);    //2
            listInt.Add(400);    //3
            listInt.Add(500);    //4

            //mylist.Add(600);    //5  Error
            Console.WriteLine("----------- Read By For ----------");
            for (int i = 0; i < listInt.ListLength; i++)
            {
                //mylist[i]
                Console.WriteLine(listInt.GetValue(i));
            }

            GenericMyList<string> listString = new GenericMyList<string>(5);  //0,1,2,3,4
            Console.WriteLine(mylist.ListLength);
            listString.Add("ahmed");    //0
            listString.Add("Mohamed");    //1
            listString.Add("Retaj");    //2
            listString.Add("Osama");    //3
            listString.Add("Karim");    //4

            //mylist.Add(600);    //5  Error
            Console.WriteLine("----------- Read By For ----------");
            for (int i = 0; i < listString.ListLength; i++)
            {
                //mylist[i]
                Console.WriteLine(listString.GetValue(i));
            }


            #endregion
            Console.ReadLine();
        }
    }

    public abstract class Person
    {
        public abstract int Id { get; set; }
        public abstract void Speak();



    }
    public class Employee : Person //:Object
    {
        public override void Speak()
        {
            throw new NotImplementedException();
        }
        public override int Id { get; set; }
        public string Name { get; set; }
        public string Job { get; set; }
        public double Salary { get; set; }
        public string Department { get; set; }


        //Polymorphism - OverLoading
        public double NetSalary()
        {
            return Salary - (Salary * 0.1); //after tax
        }
        public double NetSalary(double tax)
        {
            return Salary - (Salary * tax); //after tax
        }
        public double NetSalary(double tax, double Overtime)
        {
            return Salary - (Salary * tax) + Overtime; //after tax + Overtime
        }



        //Polymorphism(Override + Inheritance)
        public virtual void Task()
        {
            Console.WriteLine("Employee Task");
        }

        public override string ToString()
        {
            //return base.ToString();
            return $"Id {Id} \nName {Name} \nDepartment {Department} \nJob {Job} \nSalary {Salary}";
        }
    }
    public class Developer : Employee
    {
        public string ProgrammingLanguage { get; set; }
        public override void Task()
        {
            base.Task();
            Console.WriteLine("Developer Task");
            Console.WriteLine("Coding ...");
            Console.WriteLine("Testing ...");
        }

        public override string ToString()
        {
            return base.ToString() + $"\nProgrammingLanguage {ProgrammingLanguage}";
        }
    }
    public class Manager : Developer
    {
        public string Meeting { get; set; }
        //OverLoading
        public double NetSalary(double tax, double Overtime, double bonus)
        {
            return Salary - (Salary * tax) + Overtime + bonus; //after tax + Overtime
        }

        public override void Task()
        {
            base.Task();
            Console.WriteLine("Meeting ...");
            Console.WriteLine("Review Code  ...");
            Console.WriteLine("Release ...");
        }

        public override string ToString()
        {
            return base.ToString() + $"\nMeeting {Meeting}";
        }
    }
    public class CEO : Manager
    {
        public string RequestReport { get; set; }

        public new void Task()
        {
            Console.WriteLine("Take Money ...");
        }
        public new string ToString()
        {
            //return base.ToString();
            return $"Id {Id} \nName {Name} \nDepartment {Department} \nJob {Job} \nSalary {Salary} ";
        }
    }
    public class Owner : CEO
    {
        public string Company { get; set; }
        public new void Task()
        {
            Console.WriteLine("Owner Company ...");
        }
    }
    public class Client : Person
    {
        public override int Id { get => throw new NotImplementedException(); set => throw new NotImplementedException(); }

        public override void Speak()
        {
            throw new NotImplementedException();
        }
    }
    //------------------------------------
    public class InheritanceFrom   // Int32  // String  //: SealedClass :NormalClass
    {
        public string Name { get; set; }
    }
    public class InheritanceTo
    {
        public string age { get; set; }
    }
    public class NormalClass : InheritanceTo
    {

        public int Id { get; set; }

        public static void SendEmail()
        {
            Console.WriteLine("Send Email ...");
        }
    }
    public sealed class SealedClass : InheritanceTo
    {
        public int Code { get; set; }
    }
    public static class StaticClass //: InheritanceTo
    {
        static StaticClass()
        {

        }
        public static string CompanyName { get; set; }
        public static void ShowCompany()
        {
            Console.WriteLine($"Company Name {CompanyName}");
        }
    }
    public static class ExtensionClass  //: int
    {
        private static int _version;
        public static int Version { get { return _version; } set { _version = value; } }
        static ExtensionClass()
        {
            //this._version = 1;
            _version = 1;
        }
        public static int Add(this int number1, int number2)
        {
            return number1 + number2;
        }

        public static bool CheckOdd(this int x)
        {
            return x % 2 != 0;
        }
    }
    public partial class PartialClass
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
    public partial class PartialClass
    {
        public string Job { get; set; }
        public double Salary { get; set; }
    }
    //Abstraction
    public abstract class AbstractClass : PartialClass
    {
        public abstract void Save();
        public abstract void SendInfo(string message);

    }
    public abstract class Abstract2Class : AbstractClass
    {

        public abstract void LogInfo(string message);

    }
    public class test : Abstract2Class, ISendFile, ISendSMS, ISendEmail
    {
        public test()
        {
            Method1();
        }
        public override void LogInfo(string message)
        {
            throw new NotImplementedException();
        }
        public override void Save()
        {
            Console.WriteLine(" Saving ....");
        }

        public void SendEmail(string message)
        {
            throw new NotImplementedException();
        }

        public void SendFile(string message)
        {
            throw new NotImplementedException();
        }

        public override void SendInfo(string message)
        {
            Console.WriteLine($" SEND {message}");
        }

        public void SendSMS(string message)
        {
            throw new NotImplementedException();
        }
    }
    public interface ISendFile
    {
        //int x;
        void SendFile(string message);
    }
    public interface ISendEmail
    {
        void SendEmail(string message);
    }
    public interface ISendSMS
    {
        void SendSMS(string message);
    }
    public class OuterClass
    {
        public int Id { get; set; }

        public OuterClass()
        {
        }

        public class InnerClass
        {
            public int Id { get; set; }
            public InnerClass()
            {

            }
        }
    }


    public class IntLMyList
    {
        private readonly int[] _mylist;
        private int CurrentIndex = 0;
        //Non-Default
        public IntLMyList(int index)
        {
            this._mylist = new int[index];
        }
        //Property
        public int ListLength { get { return _mylist.Length; } }
        //Method Set 
        public void Add(int value)
        {
            if (CurrentIndex >= _mylist.Length)
            {
                throw new OverflowException(" My List is Over flow Length ...");
            }
            _mylist[CurrentIndex] = value;
            CurrentIndex++;
            //Logic check Over flow ???
        }
        public int GetValue(int index)
        {
            if (index >= _mylist.Length)
            {
                throw new OverflowException("Element Over flow Index ...");
            }
            return _mylist[index];
        }
    }
    //Generic Class
    public class GenericMyList<T>
    {
        //Generic Field
        private readonly T[] _mylist;
        private int CurrentIndex = 0;
        //Non-Default
        public GenericMyList(int index)
        {
            this._mylist = new T[index];
        }
        //Property
        public int ListLength { get { return _mylist.Length; } }
        //Method Set 
        //Generic Parameter
        public void Add(T value)
        {
            if (CurrentIndex >= _mylist.Length)
            {
                throw new OverflowException(" My List is Over flow Length ...");
            }
            _mylist[CurrentIndex] = value;
            CurrentIndex++;
            //Logic check Over flow ???
        }
        //Generic Method 
        public T GetValue(int index)
        {
            if (index >= _mylist.Length)
            {
                throw new OverflowException("Element Over flow Index ...");
            }
            return _mylist[index];
        }
    }
}

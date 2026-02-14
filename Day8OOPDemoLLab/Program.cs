using System.Collections;

namespace Day8OOPDemoLLab
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            #region Session Day 8 Part 1

            //Console.WriteLine("--------------- Read All Number ----------------------");
            //GenericMyList<int> Numbers = new GenericMyList<int>(3);     //Struct  Value Type 
            //Numbers.Add(100); //0
            //Numbers.Add(200); //1
            //// Numbers.Add(300); // 2
            //Numbers[2] = 300;  //assign By Indexer

            //Console.WriteLine("Read the Number with Index 2 : " + Numbers[2]);  //read By Indexer

            //Console.WriteLine("--------------- For  ----------------------");
            //for (int i = 0; i < Numbers.ListLength; i++)
            //{
            //    // Console.WriteLine(Numbers.GetValue(i));
            //    Console.WriteLine(Numbers[i]);
            //}
            ////
            //Console.WriteLine("--------------- For Each -------------------");
            //foreach (int i in Numbers)
            //{
            //    Console.WriteLine(i);
            //}
            //Console.WriteLine("--------------- END ----------------------");

            //GenericMyList<string> Names = new GenericMyList<string>(3); //Class    Reference Type 


            //GenericMyList<Manager> ManagerNames = new GenericMyList<Manager>(3);
            //GenericMyList<Employee> EmployeeNames = new GenericMyList<Employee>(3);

            ////Dictionary Generic Collection  <key, Value>
            //Dictionary<int, string> students = new Dictionary<int, string>();
            //students.Add(1, "Ahmed");
            //students.Add(2, "Ali");
            //students.Add(3, "Sara");
            //students.Add(4, "Hassan");
            //students.Add(5, "Fatima");
            //students.Add(6, "Ali");

            //Console.WriteLine("Count of Students : " + students.Count);
            //Console.WriteLine("Key 1 : " + students[1]);
            //Console.WriteLine("Key 2 : " + students[2]);
            //Console.WriteLine("Key 3 : " + students[3]);
            //Console.WriteLine("Key 4 : " + students[4]);
            //Console.WriteLine("Key 5 : " + students[5]);
            //Console.WriteLine("Key 6 : " + students[6]);
            //foreach (var item in students)
            //{
            //    Console.WriteLine($"Key: {item.Key}, Value: {item.Value}");
            //}


            #endregion

            #region Session Day 8 Part 2 LINQ
            //Collection  
            int[] Numbers = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

            //LINQ 
            //LINQ To Object Collection 

            Console.WriteLine("-----------  Query Expression ----------- ");
            //Query Expression
            var Query = from n in Numbers
                        where n % 2 == 0
                        select n;

            foreach (int item in Query)
            {
                Console.WriteLine(item);
            }
            Console.WriteLine("-----------  Lambda Expression  ----------- ");
            //Lambda Expression 
            var Query2 = Numbers.Where(n => n % 2 == 0);
            foreach (int item in Query2)
            {
                Console.WriteLine(item);
            }

            /*
                * LINQ Principles:-
                * ******************
                1)Implicit type (Var)           Done 
            */
            //2)Object Initializer.
            Employee emp = new Employee { ID = 1, Name = "Ahmed", Salary = 15000 };
            Employee emp2 = new Employee { ID = 2, Name = "Tamer", Salary = 17000 };
            //Access Object 
            emp.ID = 10;

            //3)Collection Initializer.
            //4)Anonymous Object
            List<Employee> Employees = new List<Employee>()   // Index 
            {
                new Employee  { ID = 1, Name = "Ahmed", Salary = 15000 },  //0
                new Employee  { ID = 2, Name = "Tamer", Salary = 17000 },  //1
                new Employee  { ID = 3, Name = "Hoda", Salary = 19000 },
                new Employee  { ID = 4, Name = "Mariem", Salary = 21000 },
            };
            //Employees.Add(emp);
            //Employees.Add(emp2);

            //4)Anonymous Object 
            new Employee { ID = 3, Name = "Youssef", Salary = 20000 };

            Console.WriteLine("-----------  5)Dynamic Name.  ----------- ");
            //5)Dynamic Name.  e
            var Query3 = from e in Employees
                         where e.Salary > 20000
                         select e;

            foreach (var item in Query3)
            {
                Console.WriteLine(item.ToString());
            }
            Console.WriteLine("-----------  6)Anonymous Types  ----------- ");
            //6)Anonymous Types.

            var anon = new { Id = 20, Name = "Sayed", Job = "Developer ", Address = "Alex", Salary = 15000D };
            //anon.Name = "Ali";

            //Id , Name , salary  {Name , Salary}
            var Query4 = from e in Employees
                         where e.Salary > 16000
                         select new { e.Name, e.Salary };

            foreach (var item in Query4)
            {
                Console.WriteLine($"Name {item.Name} Salary {item.Salary:C}");
            }
            Console.WriteLine("-----------  7)Generic type. IEnumerable<T>  ----------- ");
            //7)Generic type. <T>
            //8)Generic Interface
            //IEnumerable<T>
            IEnumerable<Employee> Query5 = from e in Employees
                                           where e.Salary > 16000
                                           select e;

            foreach (var item in Query5)
            {
                Console.WriteLine(item.ToString());
            }


            //9)Extension Methods. --> IEnumerable<T>
            GenericMyList<int> Numbers2 = new GenericMyList<int>(3);     //Struct  Value Type 
            Numbers2.Add(100); //0
            Numbers2.Add(200); //1
            Numbers2.Add(300); // 2

            var Query6 = Numbers2.Where(a => a % 2 == 0);


            //10)Delegate.




            /*  
                11)Build -in Delegate.
                12)Linq To Object (Linq Query).
                13)Anonymous Delegate.
                14)Anonymous Method. 
                15)Linq Lambda Expression. 
             */
            IEnumerable<Employee> Query7 = Employees.Where(x => x.Salary > 20000);

            foreach (var item in Query7)
            {
                Console.WriteLine(item.ToString());
            }

            #endregion
            Console.ReadLine();
        }
    }

    public class GenericMyList<T> : IEnumerable<T>  // where T:Employee  //where T:struct   //  where T:class
    {
        //GenericMyList[1]
        //Field Generic
        private readonly T[] _mylist;   //array 
        private int CurrentIndex = 0;
        //Non-Default
        public GenericMyList(int index)
        {
            _mylist = new T[index];
        }
        //Property
        public int ListLength { get { return _mylist.Length; } }
        //Indexer
        public T this[int index]  //1,2,0
        {
            get
            {
                // The get accessor returns the value at the specified index
                return _mylist[index];
            }
            set
            {
                //0 1  2
                // The set accessor assigns a value to the element at the specified index
                _mylist[index] = value;

            }
        }

        //Method Set
        //Generic Parameters
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

        public IEnumerator<T> GetEnumerator()
        {
            for (int i = 0; i < ListLength; i++)
            {
                yield return _mylist[i];
            }
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
    }

    //public class Employee
    //{
    //    public void get()
    //    {

    //    }
    //    public class Bank
    //    {
    //        public void get()
    //        {

    //        }
    //    }
    //}

    //public class Manager : Employee
    //{

    //    public Manager()
    //    {
    //        Employee.Bank B = new Employee.Bank();
    //        B.get();
    //    }

    //    public Employee.Bank Bank()
    //    {
    //        return null;
    //    }

    //}

    public class Employee
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public double Salary { get; set; }

        public override string ToString()
        {
            return $"ID {ID} Name {Name} Salary {Salary}"; //base.ToString();
        }
    }

}

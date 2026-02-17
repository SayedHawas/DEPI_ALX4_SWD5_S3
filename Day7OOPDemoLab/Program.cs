namespace Day7OOPDemoLab
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            #region Session 7 part 1 
            /*
            1 - Object & Class           Done
            2 - Inheritance              Access Modifier
            3 - Polymorphism             Done OverLoading
            4 - Encapsulation            Property Full - Auto (hidden Fields) | hidden Data DLL
            5 - Abstraction
            */

            /*
                ..* Task
            1 - Object & Class     Member class          
            2 - Inheritance             
            3 - Polymorphism            
            4 - Encapsulation           
            5 - Abstraction  (Abstract Class - Interface)
                Company 
             */

            int x = 100;
            int y = 100;
            bool result = x == y;
            int z = x;
            Console.WriteLine(x);
            Console.WriteLine(x += 50);
            Console.WriteLine(z);

            Console.WriteLine(result);
            Employee e1 = new Employee();
            e1.Id = 1;
            e1.Name = "Ahmed";
            Employee e2 = new Employee();
            e2.Id = 1;
            e2.Name = "Ahmed";

            bool resultRef = e1 == e2;
            Console.WriteLine(resultRef);

            Employee e3 = e1;
            e1.Id = 5;
            Console.WriteLine(e1.Id);
            Console.WriteLine(e3.Id);
            //DRY
            //Console.WriteLine(" ----------------- Read All Employee --------------- ");
            //foreach (Employee e in Employee.Employees)
            //{
            //    Console.WriteLine(e.ToString());
            //}

            //Add 
            Employee addEmp = new Employee();
            addEmp.GetAll();
            addEmp.Id = 5;
            addEmp.Name = "Sayed";
            addEmp.Code = 109;
            addEmp.Job = "Eng";
            addEmp.Save(addEmp);
            Console.WriteLine("Saving Done ....");
            addEmp.GetAll();
            //Console.WriteLine(" ----------------- Read All Employee --------------- ");
            //foreach (Employee e in Employee.Employees)
            //{
            //    Console.WriteLine(e.ToString());
            //}

            var emp = new Employee() { Id = 1, Code = 101, Name = "Mahmoud", Job = "Dev" };
            emp.Id = 5;

            new Employee { Id = 1, Code = 101, Name = "Mahmoud", Job = "Dev" };

            var xx = new { Id = 5, Salary = 50000, FullName = "SayedHawas", Email = "Sayed@yahoo.com" };
            //xx.Id = 10;

            #endregion
            Console.ReadLine();
        }
    }
}

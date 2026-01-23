namespace Day3DemoLab
{
    internal class Program
    {
        //Entry Point
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            #region Session Part 1 Review 
            //input & Output
            //Variables  (DataType)  {Value (int, char , bool , double ...) | Reference (Object , String , Array) }
            //int x = 5;
            //
            //Console.Write("Enter number 1 :");
            //int number1 = int.Parse(Console.ReadLine()); //     "12354a" --> 12354a
            //Console.Write("Enter Number 2 :");
            //int Number2;
            //int.TryParse(Console.ReadLine(), out Number2);
            ////Expression + * / % 
            //int result = number1 + Number2;
            //Console.WriteLine(result);

            //What are Data Types?
            /*
             * byte , sbyte , short , int , long    Done
             * float , double , decimal             Done   D ,F,M
             * string                               Done 
             * char                                 Done
             * bool                                 Done
             * Date time                            Done 
             * object                               Done Cast {Boxing | UnBoxing}
             * var                                  Done Implicit Datatype
             * Dynamic
             
                    +----------+----------------+---------+-------------+----------------------------------------------------------+
                    | C#       |.Net Framework  | Signed? | Bytes       | Possible Values                                          |
                    | Type     | (System)type   |         | Occupied    |                                                          |
                    +----------+----------------+---------+-------------+----------------------------------------------------------+
                    | sbyte | System.Sbyte | Yes | 1 | -128 to 127                                                                 |
                    | short | System.Int16 | Yes | 2 | -32,768 to 32,767 |
                    | int | System.Int32 | Yes | 4 | -2,147,483,648 to 2,147,483,647 |
                    | long | System.Int64 | Yes | 8 | -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 |
                    | byte | System.Byte | No | 1 | 0 to 255 |
                    | ushort | System.Uint16 | No | 2 | 0 to 65,535 |
                    | uint | System.UInt32 | No | 4 | 0 to 4,294,967,295 |
                    | ulong | System.Uint64 | No | 8 | 0 to 18,446,744,073,709,551,615 |
                    | float | System.Single | Yes | 4 | Approximately ±1.5e-45 to ±3.4e38 |
                    |          |                |         |              | with ~6 - 9 significant figures                          |
                    | double | System.Double | Yes | 8 | Approximately ±5.0e-324 to ±1.7e308 |
                    |          |                |         |              | with ~15 - 17 significant figures                        |
                    | decimal | System.Decimal | Yes | 16 | Approximately ±1.0e-28 to ±7.9e28 |
                    |          |                |         |              | with 28 - 29 significant figures                         |
                    | char | System.Char | N / A | 2 | Any Unicode character(16 bit)                          |
                    | bool | System.Boolean | N / A | 1 / 2 | true or false |
                    +----------+----------------+---------+--------------+---------------------------------------------------------+
            */
            //object ob = 123; //Boxing
            //int Total = (int)ob + 100; //Cast {UnBoxing}

            //var v = 123;
            //Console.WriteLine(v + 200);

            //dynamic dy = 125;
            //Console.WriteLine(dy + 200);   //Error Runtime


            /**
                -Implementing Conditional Logic  
                -Implementing Iteration Logic
                -Creating and Using Arrays
                -Referencing Namespaces
                -Using Breakpoints in Visual Studio 2022
             */
            //bool x = 5 > 7 && 4 < 10 ? true : false;
            //Console.WriteLine(x);

            //int? n = null;
            //n = 100;
            //int Gtotal = n ?? 0;

            //if (4 < 8 || 5 > 3)
            //{
            //    //...code 
            //}
            //else
            //{
            //    //Break Condition
            //}


            //int y = 100;
            //if (y > 10)
            //{
            //    Console.WriteLine("IF");
            //}
            //else if (y < 10)
            //{
            //    Console.WriteLine("Else ... IF 1 ");
            //}
            //else if (y == 100)
            //{
            //    Console.WriteLine("Else ... IF 2 ");
            //}
            //else
            //{
            //    Console.WriteLine("Else ...");
            //}

            //string name = "ahmed";
            //switch (name)
            //{
            //    case "ahmed":
            //    case "Ahmed":
            //        Console.WriteLine("Welcome Ahmed ...");
            //        break;
            //    case "sayed":
            //        Console.WriteLine("Welcome sayed ...");
            //        break;
            //    default:
            //        Console.WriteLine(" NAN ..");
            //        break;
            //}

            //for (int i = 0; i < 100; i++)
            //{

            //}

            //while (true)
            //{

            //}

            //do
            //{

            //} while (true);


            //Collection 
            //Array
            //int[] numbers = new int[3];
            //numbers[0] = 100;
            //numbers[1] = 200;
            //numbers[2] = 300;

            //for (int i = 0; i < numbers.Length; i++)
            //{
            //    Console.WriteLine(numbers[i]);
            //}

            //foreach (int i in numbers)
            //{
            //    Console.WriteLine(i);
            //}


            ////------------------------------------------
            //ArrayList arrlist = new ArrayList();
            //arrlist.Add(100);  //Object
            //arrlist.Add(200);
            //arrlist.Add(300);

            //for (int i = 0; i < arrlist.Count; i++)
            //{
            //    Console.WriteLine(numbers[i]);
            //}

            //foreach (var i in arrlist)
            //{
            //    Console.WriteLine(i);
            //}

            #endregion

            #region Session 3 Part1 
            //Array fix length  Storgly type 
            //ArrayList   Base Object   Counter

            //Collection Generic 
            //namespace System.Collection.Generic 
            //List<Datatype> < Name > = new List<Datatype>();

            // DayC# 3  Q ?  +5
            // Array  List<>  ?

            //int[] n = new int[3] { 1, 1000, 2000 };

            //List<int> numbers = new List<int>();
            //numbers.Add(100);    // 0
            //numbers.Add(200);    //1
            //numbers.Add(10);     //2
            //numbers.AddRange(n);

            //numbers.Insert(0, 500);
            //Console.WriteLine("Read Collection List By For ");
            //for (int i = 0; i < numbers.Count; i++)
            //{
            //    Console.WriteLine(numbers[i]);
            //}
            //Console.WriteLine("----------------------------");
            //Console.WriteLine("Read Collection List By For Each After Sort ");
            //numbers.Sort();
            //foreach (int item in numbers)
            //{
            //    Console.WriteLine(item);
            //}




            #endregion

            #region Session 3 Part 2
            int m;
            Console.Write("Enter number1 :");
            int.TryParse(Console.ReadLine(), out m);


            /*
                1-What Is a Method?                   Done
                2-Types Of Methods                    Done
                     1) Static Method                 Done
                         - Call into static Method , Without Object 
                     2) Instance Method  (NonStatic) Done
                         - Must Create Object To call it .

                      Void                      Done
                      Return DataType           Done

                3-Creating a Method             Done
                4-Calling a Method              Done
                5-Method With Parameters | Arguments .   Done 

                6-Pass Parameters With Value & Ref & Out  Done
                9-Overloaded Methods            Done
                //--------------------------------------------
                7-Using Parameter Arrays
                8-Key Words Param 
                
             */

            //Call Invock Method 
            //Save  Action 
            SayHello("Osama");
            SayHello("Ahmed");
            SayHello("Mariem");

            int Age = SayMyAge(new DateTime(1980, 1, 1));
            Console.WriteLine(Age);
            Console.WriteLine(SayMyAge(new DateTime(1980, 1, 1)));
            //Select   Return

            //Program p = new Program(); //Create Object 
            //p.SayWelcome();

            SayWelcome2();

            NetSalary();
            NetSalary(17000);
            NetSalary(18000, 1800, 5000);
            //Calling By Names
            NetSalary(tax: 100, salary: 19000, overTime: 3000);
            NetSalary(18000, 1800, 5000, 200);


            //6 - Pass Parameters With Value & Ref & Out
            Console.WriteLine("Pass Param To Method By Value ");
            int x = 10;
            Console.WriteLine(x);
            Console.WriteLine(AddValueFive(x));
            Console.WriteLine(x);

            Console.WriteLine("Pass Param To Method By Ref ");
            Console.WriteLine(x);
            Console.WriteLine(AddValueFiveRef(ref x));
            Console.WriteLine(x);

            Console.WriteLine("Pass Param To Method By out ");

            string result;
            GetAge(1990, out result);
            Console.WriteLine(result);

            GetAge(2007, out result);
            Console.WriteLine(result);

            #endregion
            Console.ReadLine();
        }

        //Access Modifier { Public , Private }
        //Access Modifier static void | Datatype<MethodName>(Params,,)
        //{

        //}
        //Create Method  Void 
        public static void SayHello(string name)
        {
            Console.WriteLine($"Hello {name}");
        }
        public static void SayWelcome2()
        {
            Console.WriteLine("Welcome in My Void ...");
        }
        //Create Method  Return DataType
        public static int SayMyAge(DateTime dateOfBirth)
        {
            return DateTime.Now.Year - dateOfBirth.Year;
        }
        //Method Void Non-Static (Object Instance)
        public void SayWelcome()
        {
            Console.WriteLine("Welcome in My Void ...");
        }

        //OverLoad 
        public static void NetSalary()  //Head
        {
            Console.WriteLine("Your Salary is 15000 ");   //body
        }
        public static void NetSalary(double salary)
        {
            Console.WriteLine($"Your Salary is {salary}");
        }
        public static void NetSalary(double salary, double tax)
        {
            Console.WriteLine($"Your Salary is {salary - tax}");
        }
        public static void NetSalary(double salary, double tax, double overTime)
        {
            Console.WriteLine($"Your Salary is {salary - tax + overTime}");
        }
        public static void NetSalary(double salary, double tax, double overTime, double discount)
        {
            Console.WriteLine($"Your Salary is {salary - tax + overTime - discount}");
        }



        // 6-Pass Parameters With Value & Ref & Out

        public static int AddValueFive(int num) //input parameters
        {
            num += 5;
            return num;
        }
        public static int AddValueFiveRef(ref int num)
        {
            num += 5;
            return num;
        }


        public static void GetAge(int year, out string status) //output
        {
            int result = DateTime.Now.Year - year;
            Console.WriteLine($"Your Age is {result} ...");
            if (result >= 21)
                status = "Accept";
            else
                status = "Reject";
        }

    }
}

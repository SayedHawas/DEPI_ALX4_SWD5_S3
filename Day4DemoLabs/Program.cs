namespace Day4DemoLabs
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World! Day 4 C-Sharp ");

            /*
                1-Pass Parameters With Value & Ref & Out             Done
                2-Using Parameter Naming Optional Parameters         Done
                3-Using Parameter Arrays                             Done
                4-Key Words Params                                   Done
                5-Overloaded Methods                                 Done

                6- String Array Char                                 Done
            // Exception Handling
            1-Try ... Catch 
            2-Try ... Catch ... Finally
            3-Raising (Throwing) Exceptions
             */
            #region Session 4 Part1

            //int number = 0;
            //int Total = 100 + number; //Expression


            ////6-Pass Parameters With Value & Ref & Out
            //Console.WriteLine("------------ By Value ------------");
            ////Pass By Value 
            //int x = 100;
            //Console.WriteLine(x);
            //Add(x);
            //Console.WriteLine(x);
            //// Pass Value 
            //Add(200);

            //Console.WriteLine("------------ By Ref ------------");
            ////Pass By Value 
            //int x1 = 100;
            //Console.WriteLine(x1);
            //RefAdd(ref x1);
            //Console.WriteLine(x1);
            //// must Pass Variables 
            ////RefAdd(ref 200);


            //Console.WriteLine("------------ By Out ------------");
            //string curr;
            //int returnValue;
            //int x2 = 100;
            //Console.WriteLine(x2);
            //OutAdd(x2, out returnValue, out curr);

            //Console.WriteLine($"{returnValue} {curr}");

            ////2 - Using Parameter Naming Optional Parameters
            //Console.WriteLine("------------ Call By Name------------");
            //Sum(100, 200, 50);
            ////Calling By Name 
            //Sum(z: 40, x: 10, y: 50);
            //Sum(y: 100, x: 200, z: 400);
            //Console.WriteLine("------------ Call By Optional ------------");
            //Sum(100, 300);
            //Sum(100);
            //Sum(100, 100);
            //Sum(z: 200);
            //Sum();

            ////3 - Using Parameter Arrays
            //int[] numbers = new int[] { 1, 22, 55, 85, 74, 100 };
            //Console.WriteLine(SumArray(10, numbers));
            ////4 - Key Words Params
            //Console.WriteLine(SumArray(x: 0, 2, 55, 44, 66, 900));
            //Console.WriteLine(SumArray(x: 10, 2, 55, 44, 66, 900));

            ////5-Overloaded Methods Calling 
            //Console.WriteLine(OperatorSum(100, 200));
            //Console.WriteLine(OperatorSum(100, 200, 200));
            //Console.WriteLine(OperatorSum(100, 200, 500, "Sayed"));
            //Console.WriteLine(OperatorSum(100.5, 200.25, 500.50, "Ahmed"));
            //Console.WriteLine(SumArray("Ahmed", "Sayed", "Retaj"));




            ////6 - String Array Char     (CTS CLR JIT)
            //// Int32   , Int64   , Int 16
            //short s = 50;
            //long l = 200;


            //int i = 100;
            //Int32 I = new Int32();
            //I = 100;

            //string name = "Ahmed";

            //char[] name2 = new char[] { 'A', 'h', 'm', 'e', 'd' };
            //String name3 = new String(name2);

            //Console.WriteLine(name[0]);
            //Console.WriteLine(name.Length);


            //Console.WriteLine("-------------------------------------------------");
            //int count;
            //Console.WriteLine(SumArray(out count, x: 100, 10, 20, 50, 44, 8, 66, 31));
            //Console.WriteLine($"Count {count}");

            //int count1;
            //Console.WriteLine(SumArray(out count1, numbers: [100, 10, 20, 50, 44, 8, 66, 31]));
            //Console.WriteLine($"Count {count1}");


            //Console.WriteLine(NetSalary(15000));
            //Console.WriteLine(NetSalary(15000, 2000));
            //Console.WriteLine(NetSalary(15000, 2000, 500));
            //Console.WriteLine(NetSalary(15000, 2000, 500, .1));
            //Console.WriteLine(NetSalary(15000, 2000, 500, .1, 1000));

            //double TDisc;
            //double TAdd;
            //Console.WriteLine(NetSalary(15000, 2000, 500, .1, 1000, out TDisc, out TAdd));
            //Console.WriteLine($"Total Dis {TDisc}");
            //Console.WriteLine($"Total Add {TAdd}");

            #endregion
            #region Session 4 Part 2
            //Error  Bug   Debug

            //Exception Handling
            //1 - Try... Catch                     Done
            //2 - Try... Catch... Finally          Done
            //3 - Raising(Throwing) Exceptions     Done

            try
            {
                Console.Write("Enter your Number1 :");
                int number1 = int.Parse(Console.ReadLine());  // Parse Remove ""  "12354" -> 12345

                Console.Write("Enter your Number2 :");
                int number2 = int.Parse(Console.ReadLine());

                //Object ob = null;
                //number2 = (int)ob;
                int Total = number1 + number2;
                Console.WriteLine($"Result For {number1} / {number2} = {number1 / number2}");
            }
            catch (FormatException)
            {
                Console.WriteLine("Please Enter Numbers Only ....");
            }
            catch (OverflowException)
            {
                Console.WriteLine($"Please Enter Numbers between {int.MinValue} And {int.MaxValue}");
            }
            catch (NullReferenceException)
            {
                Console.WriteLine($"Please Enter Numbers Not Null ....");
            }
            catch (DivideByZeroException)
            {
                Console.WriteLine($"Please Enter Numbers2 Gt 0  Can Not Divide By Zero ....");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Call Support  0125515651513 ....");
                Console.WriteLine(ex.Message);
            }
            finally
            {
                Console.WriteLine("Finish Operation");
            }
            Console.WriteLine("Finish Program ....");

            try
            {
                Console.WriteLine(Divide(100, 2));
                Console.WriteLine(Divide(100, 0));
                //
                Console.WriteLine(Divide(100, 2));
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }


            try
            {
                Console.WriteLine(FullName("Sayed", "Said", "Hawas"));
                Console.WriteLine(FullName("    ", "Said", "Hawas"));
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            #endregion
            Console.ReadLine();
        }

        public static void Add(int x)  //Pass Value 
        {
            Console.WriteLine(x += 10);
        }
        public static void RefAdd(ref int x) //Pass Ref
        {
            Console.WriteLine(x += 10);
        }
        public static void OutAdd(int x, out int value, out string currency) //x intput Param , value out
        {
            currency = "$";
            value = 10;
            Console.WriteLine(x += 10);
        }
        public static void Sum(int x = 10, int y = 10, int z = 10)
        {
            Console.WriteLine(x + y + z);
        }
        public static int SumArray(params int[] numbers)
        {
            int total = 0;
            for (int i = 0; i < numbers.Length; i++)
            {
                total += numbers[i];
            }
            return total;
        }
        public static int SumArray(int x = 0, params int[] numbers)
        {
            int total = 0;
            for (int i = 0; i < numbers.Length; i++)
            {
                total += numbers[i];
            }
            return total + x;
        }
        public static int SumArray(out int Counter, int x = 0, params int[] numbers)
        {
            int total = 0;
            int c = 0;
            for (int i = 0; i < numbers.Length; i++)
            {
                total += numbers[i];
                c++;
            }
            Counter = c;
            return total + x;
        }
        public static string SumArray(params string[] numbers)
        {
            string total = string.Empty;
            for (int i = 0; i < numbers.Length; i++)
            {
                total += numbers[i] + " ,";
            }
            total = total.Substring(0, total.Length - 1);
            return total;
        }
        //5-Overloaded Methods
        public static int OperatorSum()
        {
            return 0;
        }
        public static int OperatorSum(int x)
        {
            return x;
        }
        public static int OperatorSum(int x, int y)   //Head 
        {
            return x + y;                             //Body
        }
        public static int OperatorSum(int x, int y, int z)
        {
            return x + y + z;
        }
        public static string OperatorSum(int x, int y, int z, string name)
        {
            return $"{name} {x + y + z}";
        }
        public static string OperatorSum(double x, double y, double z, string name)
        {
            return $"{name} {x + y + z}";
        }
        public static double NetSalary(double Salary)
        {
            return Salary;
        }
        public static double NetSalary(double Salary, double Overtime)
        {
            return Salary + Overtime;
        }
        public static double NetSalary(double Salary, double Overtime, double Discount)
        {
            return Salary + Overtime - Discount;
        }
        public static double NetSalary(double Salary, double Overtime, double Discount, double tax)
        {
            double taxValue = Salary * tax;
            return Salary + Overtime - Discount - taxValue;
        }
        public static double NetSalary(double Salary, double Overtime, double Discount, double tax, double Bouns)
        {
            double taxValue = Salary * tax;
            return Salary + Overtime - Discount - taxValue + Bouns;
        }
        public static double NetSalary(double Salary, double Overtime, double Discount, double tax, double Bouns, out double TotalDiscount, out double TotalAddational)
        {
            double taxValue = Salary * tax;
            TotalDiscount = taxValue + Discount;
            TotalAddational = Overtime + Bouns;
            return Salary + Overtime - Discount - taxValue + Bouns;
        }

        //----------------------


        /// <summary>
        ///  This Method To Divide Two number 
        /// </summary>
        /// <param name="a"> double number </param>
        /// <param name="b"> double number</param>
        /// <returns>double number by a/b </returns>
        /// <exception cref="DivideByZeroException"></exception>
        /// <exception cref="OverflowException"></exception>
        public static double Divide(double a, double b)
        {
            if (b == 0)
            {
                //throw new Exception("Can Not Divide By Zero ....");
                throw new DivideByZeroException("Can Not Divide By Zero ....");
            }
            return a / b;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="firstName"></param>
        /// <param name="MedName"></param>
        /// <param name="LastName"></param>
        /// <returns></returns>
        /// <exception cref="ArgumentException"></exception>
        public static string FullName(string firstName, string MedName, string LastName)
        {
            if (firstName.Length == 0 || firstName.Trim() == "")
            {
                throw new ArgumentException("must Enter First Name ....");
            }
            return $"Full Name is {firstName} {MedName} {LastName} .";
        }

    }
}

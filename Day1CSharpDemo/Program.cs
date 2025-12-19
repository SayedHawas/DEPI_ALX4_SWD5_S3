namespace Day1CSharpDemo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            #region Session Part 1
            ////Comment
            ///*
            // * 1)Variables & Data Types:-
            // * 2) Const 
            // * byte , sbyte , short , int , long
            // * float , double , decimal 
            // * string 
            // * char
            // * bool
            // * Date time
            // *-------------
            // * Object                        Done   Reference , Boxing  / handling (Cast) Unboxing
            // * Var                           Done   Implicit DataType   / Not Null 
            // * Dynamic                       Done   Allow Change   But Error In Runtime 
            // */

            //const string ApplicationName = "Smart Software";
            ////ApplicationName = "Smart";


            ////int.MinValue

            ////Input & Output 
            //Console.WriteLine("Welcome in C# ....");
            //Console.Write("Enter your Name :");
            ////<Datatype>  VariableName  = "Value";
            ////string name = Console.ReadLine();  //"Sayed Hawas";
            ////Console.WriteLine("Hello " + name);

            //byte NumberByte = 255;
            //sbyte NumberSByte = -127;
            //int NumberInt = 25857585;
            //long NumberLong = 65654654654564;

            //float NumberFloat = 1.25687f;
            //double NumberDouble = 1.2654588d;
            //decimal NumberDecimal = 1.3215121221M;

            //float flt = 1F / 3;
            //double dbl = 1D / 3;
            //decimal dcm = 1M / 3;
            ////Console.WriteLine("float: {0} double: {1} decimal: {2}", flt, dbl, dcm);
            //Console.WriteLine($"float: {flt} \ndouble: {dbl} \ndecimal: {dcm}");
            ////Console.WriteLine($"Welcome {name} Number {NumberByte} ");


            //char letter = 'A';
            //Console.WriteLine($"My Select Letter is {letter}");

            //bool BooleanType = 4 > 5;
            //Console.WriteLine($"Result id :  {BooleanType}");

            //DateTime dtNow = DateTime.Now;
            //Console.WriteLine($"Date&Time is {dtNow}");



            //Console.WriteLine($"byte   : {byte.MinValue} to {byte.MaxValue}");
            //Console.WriteLine($"ushort : {ushort.MinValue} to {ushort.MaxValue}");
            //Console.WriteLine($"uint   : {uint.MinValue} to {uint.MaxValue}");
            //Console.WriteLine($"ulong  : {ulong.MinValue} to {ulong.MaxValue}");

            ////Expressions and Operators in Visual C#

            ////byte b = 255;
            //int x = 5;
            //int y = 6;

            //int z = x * y;
            //z = x - y;
            //z = x / y;
            //z = x + y;

            //Console.WriteLine("Total is : " + x + y);
            //Console.WriteLine(x + y + " total ");
            //Console.WriteLine("Total " + (x + y));

            ////+ , - , * , / , %
            //// Assignment operator
            //int n1 = 2;
            //int n2 = 4;
            //// Addition operator
            //Console.WriteLine(n1 + n2);
            //// Subtraction operator
            //Console.WriteLine(n1 - n2);
            //// Division operator
            //Console.WriteLine(n1 / n2);
            //// Multiplication operator 
            //Console.WriteLine(n1 * n2);
            //Console.WriteLine(n1 % n2);

            //int I = 100;
            //I = I + 5;
            //I += 5;
            //I *= 5;
            //I /= 5;

            //I++;//PostFix
            //++I;//Prefix
            //I--;
            //--I;

            //int H = 100;
            //Console.WriteLine(H++);
            //Console.WriteLine(H);

            //Console.WriteLine(++H);



            //Math.Round(1.588);
            //Console.WriteLine("Cube of Number Is " + System.Math.Pow(3, 3));


            ////Nullable 
            //int m = 0;

            //object obj2 = null;
            //string str = null;
            //string str2 = "";
            //string strEmpty = string.Empty;


            ////Object 
            //object obj = 12.5;
            //double total = 10.25 + (double)obj;
            //Console.WriteLine(total);
            //obj = "Ali";
            //obj = DateTime.Now;

            ////Implicitly Datatype 
            //var number = 100;
            ////number = 1.2;
            //var str3 = (string)null;


            //int? xx = null;
            //int TotalInt = xx ?? 0;

            ////dynamic
            //dynamic dy = 100;
            //int Result1 = dy + 200;
            //Console.WriteLine(Result1);
            //dy = "ahmed";
            //string Result2 = dy + " Ali ";
            //Console.WriteLine(Result2);

            //dynamic str5 = "Welcome in C# ";
            //Console.WriteLine(str5.Length);

            ////dynamic num = 100;
            ////Console.WriteLine(num.Length);  //Error Runtime
            #endregion 

            //Convert
            int x = 100;
            long y = x; //Implicit Convert 


            long l = 100000000;
            x = (int)l;   //Cast

            int n = 0;
            int t = 5 * n;

            Console.Write("Enter Number 1 : ");
            double number1;
            double.TryParse(Console.ReadLine(), out number1);
            //double number1 = double.Parse(Console.ReadLine());
            double number2;
            Console.Write("Enter Number 2 : ");
            double.TryParse(Console.ReadLine(), out number2);
            //double number2 = double.Parse(Console.ReadLine());

            double Result = number1 * number2;
            Console.WriteLine($"{number1} X {number2} = {Result}");


            int A = 65;
            char a = Convert.ToChar(A);
            Console.WriteLine(a);

            Console.WriteLine("Sayed Hawas");
            Console.WriteLine("Sayed       Hawas");
            Console.WriteLine("Sayed\t Hawas");
            Console.WriteLine("----------------");
            Console.WriteLine("Sayed\n Hawas");
            Console.WriteLine("Sayed \"Said\" Hawas");
            Console.WriteLine("c\\folder\\Ahmed.doc");
            Console.WriteLine(@"c\folder\Ahmed.doc");
            Console.WriteLine("\a"); // beep 
            Console.WriteLine("\0"); // Null


            Console.ReadLine();
        }
    }
}

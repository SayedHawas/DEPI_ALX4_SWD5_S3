//namespace 
using System.Collections;

namespace Day2ConsoleDemo
{
    //class
    internal class Program
    {
        //Entry Point
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!   --- C # Day 2  ----");
            #region Session 1
            /*
            -Implementing Conditional Logic
            -Implementing Iteration Logic
            -Creating and Using Arrays
            -Referencing Namespaces
            -Using Breakpoints in Visual Studio 2022
             */
            #endregion

            #region Session2
            /*
                  < > <= >= == != &&
                 */
            //Ternary Operator ( &&  ||  !) ? :
            //int x = 10;
            //bool result = x > 5;

            //string resultStr = x > 5 ? "True" : "false";
            //Console.WriteLine(resultStr);
            //resultStr = x > 9 && x < 20 ? "True" : "false";  //And First False
            //resultStr = x > 9 || x < 20 ? "True" : "false";  //OR First True 

            //if (x > 10)
            //{
            //    Console.WriteLine("true");
            //}
            //else
            //{
            //    Console.WriteLine("false");
            //}


            //if (x > 10)
            //{
            //    Console.WriteLine("true");
            //}
            //else if (x < 10)
            //{
            //    Console.WriteLine("false");
            //}
            //else
            //{
            //    Console.WriteLine("Equal");
            //}

            ////Nest IF 
            //Console.Write("Enter UserName :");
            //string userName = Console.ReadLine();
            //Console.Write("Enter Password :");
            //string password = Console.ReadLine();
            //if ((userName == "ahmed" && password == "123")
            //    || (userName == "sayed" && password == "222"))
            //{
            //    if (userName == "ahmed")
            //    {
            //        Console.WriteLine($"Welcome Admin {userName}");
            //    }
            //    else
            //    {
            //        Console.WriteLine($"Welcome {userName}");
            //    }
            //}
            //else
            //{
            //    Console.WriteLine("Invalid Username Or Password ....");
            //}

            //object ob = null;
            //int? y = 20;

            //y = (int?)ob;

            //switch (y)
            //{

            //    case < 5:
            //        Console.WriteLine("Lt 5");
            //        break;
            //    case 5:
            //        Console.WriteLine("Equal 5");
            //        break;
            //    case > 5:
            //        Console.WriteLine("Gt 5");
            //        break;
            //    default:
            //        Console.WriteLine("Invalid Data NULL");
            //        break;
            //}

            //Console.WriteLine("plz enter user name");
            //string uname = Console.ReadLine();
            //switch (uname)
            //{
            //    case "ahmed":
            //    case "Ahmed":
            //        Console.WriteLine("Hello Admin");
            //        break;
            //    case "Fawzy":
            //    case "fawzy":
            //        Console.WriteLine("Hello User");
            //        break;
            //    default:
            //        Console.WriteLine("invalid user");
            //        break;
            //}

            //Console.WriteLine("plz enter num1");
            //int num1 = int.Parse(Console.ReadLine());
            //Console.WriteLine("plz enter num2");
            //int num2 = int.Parse(Console.ReadLine());
            //Console.WriteLine("plz enter operator");
            //char op = char.Parse(Console.ReadLine());
            //switch (op)
            //{
            //    case '+':
            //        Console.WriteLine(num1 + num2);
            //        break;
            //    case '-':
            //        Console.WriteLine(num1 - num2);
            //        break;
            //    case '*':
            //        Console.WriteLine(num1 * num2);
            //        break;
            //    case '/':
            //        Console.WriteLine(num1 / num2);
            //        break;
            //    default:
            //        Console.WriteLine("invalid operator");
            //        break;
            //}

            Console.WriteLine("For");
            //Loops 
            //for (int i = 0; i <= 10; i++)
            //{
            //    if (i > 5)
            //    {
            //        break;
            //    }
            //    Console.WriteLine(i);
            //}

            Console.WriteLine("For");
            //Loops 
            //for (int i = 0; i <= 10; i++)
            //{
            //    if (i < 5)
            //    {
            //        continue;
            //    }
            //    Console.WriteLine(i);
            //}

            //for (int i = 1; i <= 12; i++)
            //{
            //    Console.WriteLine($"------{i}----------");
            //    for (int m = i; m <= 12; m++)
            //    {
            //        Console.WriteLine($"{i} X {m} = {i * m}");
            //    }
            //    Console.WriteLine($"-------------------");
            //}

            //start:
            //    Console.Clear();
            //    Console.Write("plz enter num1 :");
            //    int num1 = int.Parse(Console.ReadLine());
            //    Console.Write("plz enter num2 :");
            //    int num2 = int.Parse(Console.ReadLine());
            //    Console.Write("plz enter operator :");
            //    char op = char.Parse(Console.ReadLine());
            //    switch (op)
            //    {
            //        case '+':
            //            Console.WriteLine(num1 + num2);
            //            break;
            //        case '-':
            //            Console.WriteLine(num1 - num2);
            //            break;
            //        case '*':
            //            Console.WriteLine(num1 * num2);
            //            break;
            //        case '/':
            //            Console.WriteLine(num1 / num2);
            //            break;
            //        default:
            //            Console.WriteLine("invalid operator");
            //            break;
            //    }
            //    Console.WriteLine("Press any key");
            //    Console.ReadLine();
            //    goto start;

            //Console.WriteLine("While");
            //int n = 0;
            //while (n < 10)
            //{
            //    Console.WriteLine(n++);
            //}
            //Console.WriteLine("Do While");
            //int v = 0;
            //do
            //{
            //    Console.WriteLine(v++);
            //}
            //while (v < 10);



            //char ans;
            //do
            //{
            //    Console.Clear();
            //    Console.Write("plz enter num1 :");
            //    int num1 = int.Parse(Console.ReadLine());
            //    Console.Write("plz enter num2 :");
            //    int num2 = int.Parse(Console.ReadLine());
            //    Console.Write("plz enter operator :");
            //    char op = char.Parse(Console.ReadLine());
            //    switch (op)
            //    {
            //        case '+':
            //            Console.WriteLine(num1 + num2);
            //            break;
            //        case '-':
            //            Console.WriteLine(num1 - num2);
            //            break;
            //        case '*':
            //            Console.WriteLine(num1 * num2);
            //            break;
            //        case '/':
            //            Console.WriteLine(num1 / num2);
            //            break;
            //        default:
            //            Console.WriteLine("invalid operator");
            //            break;
            //    }
            //    Console.WriteLine("Press Y | y Key to repeat ...");
            //    ans = char.Parse(Console.ReadLine());
            //} while (ans == 'y' || ans == 'Y'); 
            #endregion


            #region Session3
            //Array 
            //int[] x = new int[3];
            //x[0] = 40;
            //x[1] = 5;
            //x[2] = 30;

            //Console.WriteLine(x[2]);
            //Console.WriteLine("For Read Array ...");
            //for (int i = 0; i < x.Length; i++)
            //{
            //    Console.WriteLine(x[i]);
            //}

            //Array.Sort(x);
            //foreach (var i in x)
            //{
            //    Console.WriteLine(i);
            //}

            //double[] d = new double[] { 1.05, 2.5, 33.5, 5.33 };
            //Console.WriteLine(d.Length);
            //foreach (var i in d)
            //{
            //    Console.WriteLine(i);
            //}
            //x[3] = 40;
            int index;
            Console.Write("Enter Number Of Books :");
            int.TryParse(Console.ReadLine(), out index);
            string[] Books = new string[index];
            for (int i = 0; i < Books.Length; i++)
            {
                Console.Write($"Enter the Title For Book No {i + 1}:");
                Books[i] = Console.ReadLine();
            }
            Console.WriteLine("Press an key To print Library");
            Array.Sort(Books);
            foreach (var item in Books)
            {
                Console.WriteLine($"{item}");
            }
            Console.Write("Enter Title For Search :");
            string search = Console.ReadLine();
            int result = Array.IndexOf(Books, search);
            string ShowResult = result > -1 ? Books[result] : "Book Not Found...";
            Console.WriteLine(ShowResult);

            //int[,] Number = new int[2,3];
            //Number[0,0]

            //2D 
            int[,] x = new int[2, 3] { { 1, 20, 200 }, { 2, 300, 400 } };

            for (int i = 0; i < x.GetLength(0); i++)
            {
                for (int l = 0; l < x.GetLength(1); l++)
                {
                    Console.Write(x[i, l] + "\t");
                }
                Console.WriteLine();
            }


            ArrayList Arrylist = new ArrayList();
            Arrylist.Add(100);
            Arrylist.Add("Ahmed");
            Arrylist.Add(1.2);

            int total = 5 + (int)Arrylist[0];

            #endregion
            Console.ReadLine();

        }
    }
}

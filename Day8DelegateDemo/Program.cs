namespace Day8DelegateDemo
{
    internal class Program
    {

        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");

            //Event        -- > Delegate  -->        Method() 
            /*
                 - Delegates is A Function Pointer
                 - Delegate  is a type safe Function
                 - Delegate  is Reference type (Heap) 
                 - the Signature of Delegate Must Match the Signature Of Function Pointed it. 
            */

            //Delegate.
            SayHelloHandler sh = new SayHelloHandler(SayHello);
            Console.WriteLine(sh.Invoke("SayedHawas"));

            /* Build-in Delegate.
                    *) Delegate Type Like: (Func, Action, Predicate)
                    *) Delegate is the Pointer to Method

                    Delegate Type Like: -
                    ---------------------
                    - Func      : delegate Which return One Value.                 16 Input parameters  With Return(Function) 17 Output
                    - Func<int, int> increment = i => i + 1;

                    -Action    : delegate which not return Value. =Void            16 Input parameters Without Return(Void)
                    -Action<int> d = x => Console.WriteLine(x);

                    -Predicate : delegate which return bool only.
                    - predicate<int> cc = c => true; 1 Input parameters With Return(True Or False)
                    ----------------------------------------------------------------------------------------------------------------------------
                  */

            //14)Anonymous Method. 

            Func<int, int, int> test = delegate (int x, int y) { return x + y; };
            Console.WriteLine(test(100, 200));

            Action<string, string> sayInfo = delegate (string m, string s) { Console.WriteLine(m + " " + s); };
            sayInfo("Demo", "LINQ");

            Predicate<int> Check = delegate (int score) { return score > 50; };
            Console.WriteLine(Check(100));
            Console.WriteLine(Check(20));

            //13)Anonymous Delegate.
            //15)Linq Lambda Expression.

            Func<int, int, int> test2 = (x, y) => x + y;
            Predicate<int> Check2 = x => x > 50;

        }

        public delegate string SayHelloHandler(string message);
        public static string SayHello(string name)
        {
            return "Hello " + name;
        }
    }
}

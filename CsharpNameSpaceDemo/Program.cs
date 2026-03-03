using Day8DLLDemo;

namespace CsharpNameSpaceDemo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            Employee e = new Employee()
            { ID = 1, Name = "John", Job = "Developer", Salary = 50000, Attend = true };

        }
    }
}

namespace HelpCode
{
    public class HelpClass
    {
        public void HelpMethod()
        {
            Console.WriteLine("This is a help method.");
        }
    }
}

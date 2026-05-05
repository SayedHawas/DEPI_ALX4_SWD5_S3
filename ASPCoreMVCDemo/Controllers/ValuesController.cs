using ASPCoreMVCDemo.Models;
using Microsoft.AspNetCore.Mvc;

namespace ASPCoreMVCDemo.Controllers
{
    //Routing is the process of mapping incoming HTTP requests to the appropriate controller actions.
    //https://localhost:7072/values/index
    public class ValuesController : Controller
    {
        public IActionResult Index()
        {
            return View(); //values/index
        }
        //{controller=Home}/{action=Index}/{id?}
        //https://localhost:7072/values/ShowNumber/40
        public IActionResult ShowNumber(int id)
        {
            return Content($"Your Number is {id}");
        }
        //https://localhost:7072/values/ShowAge/?age=40
        public IActionResult ShowAge(int age)
        {
            return Content($"Your age is {age}");
        }
        //https://localhost:7072/values/ShowName/?name=sayed
        public IActionResult ShowName(string name)
        {
            //ViewData["x"] = name;
            ViewData["x"] = name;

            ViewData["Number1"] = 100;
            ViewData["Number2"] = 200;

            ViewBag.y = "Welcome in My app";
            ViewBag.N1 = 1000;
            ViewBag.N2 = 2000;
            return View();

        }

        public IActionResult ShowData()
        {

            List<Employee> employees = new List<Employee>()
            {
                new Employee(){Id=1,Name="Sayed",Department="IT",Salary=5000},
                new Employee(){Id=2,Name="Ahmed",Department="Accounting",Salary=4000},
                new Employee(){Id=3,Name="Ali",Department="HR",Salary=3000},
            };
            return View(employees);//View(employees);

        }

        public IActionResult ShowEmployee(int id)
        {
            List<Employee> employees = new List<Employee>()
            {
                new Employee(){Id=1,Name="Sayed",Department="IT",Salary=5000},
                new Employee(){Id=2,Name="Ahmed",Department="Accounting",Salary=4000},
                new Employee(){Id=3,Name="Ali",Department="HR",Salary=3000},
            };

            Employee emp = employees.FirstOrDefault(e => e.Id == id);
            return View(emp);
        }
    }
}

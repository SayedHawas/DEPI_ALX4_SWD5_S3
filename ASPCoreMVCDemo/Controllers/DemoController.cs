using Microsoft.AspNetCore.Mvc;

namespace ASPCoreMVCDemo.Controllers
{
    public class DemoController : Controller
    {
        public ActionResult<string> Sayhello(string name)
        {
            return $"Hello World! {name}";
        }

        public IActionResult EmptyResult()
        {
            return new EmptyResult();
        }

        public IActionResult JsonResult()
        {
            return new JsonResult(new { Name = "John", Age = 30 });
        }

        public IActionResult ContentResult()
        {
            return new ContentResult { Content = "<h1> Welcome in HTML </h1>", ContentType = "text/html" };
        }

        public IActionResult ShowView()
        {
            return View("~/Views/MyView/SmartView.cshtml");
        }


        public ActionResult Index()
        {
            return View();
        }
    }
}

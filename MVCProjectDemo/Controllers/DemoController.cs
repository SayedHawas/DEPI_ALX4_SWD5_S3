using Microsoft.AspNetCore.Mvc;

namespace MVCProjectDemo.Controllers
{
    public class DemoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}

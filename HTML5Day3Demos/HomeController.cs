using Microsoft.AspNetCore.Mvc;

namespace HTML5Day3Demos
{
    public class HomeController : Controller
    {
        public IActionResult Index(string password, string username)
        {
            return View();
        }
    }
}

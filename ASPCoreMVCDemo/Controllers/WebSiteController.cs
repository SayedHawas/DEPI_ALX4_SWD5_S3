using Microsoft.AspNetCore.Mvc;

namespace ASPCoreMVCDemo.Controllers
{
    public class WebSiteController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}

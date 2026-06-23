using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace MVCProjectDemo.Controllers
{
    public class FullDemoController : Controller
    {
        // GET: FullDemoController
        public ActionResult Index()
        {
            return View();
        }

        // GET: FullDemoController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: FullDemoController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: FullDemoController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: FullDemoController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: FullDemoController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: FullDemoController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: FullDemoController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}

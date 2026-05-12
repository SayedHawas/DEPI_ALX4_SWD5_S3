using ASPCoreMVCDemo.Data;
using ASPCoreMVCDemo.Models;
using Microsoft.AspNetCore.Mvc;

namespace ASPCoreMVCDemo.Controllers
{
    //https://localhost:7072/Catgories/Index
    public class CategoriesController : Controller
    {
        private readonly AppDbContext _db;
        public CategoriesController(AppDbContext db)
        {
            _db = db;
        }

        //Get All Data 
        [HttpGet]
        public IActionResult Index()
        {
            var categoriesList = _db.Categories.ToList();
            // ViewBag.List = categoriesList;
            return View(categoriesList);
        }
        //https://localhost:7072/Catgories/Details/100
        //Get One Row By Id 

        [HttpGet]
        public IActionResult Details(int id)
        {
            var category = _db.Categories.FirstOrDefault(c => c.CategoryId == id);
            return View(category);
        }


        //Create To view Empty 
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }


        //Create To Post 
        [HttpPost]
        public IActionResult Create(Category newCategory) //string name , string description)
        {
            if (ModelState.IsValid)
            {
                _db.Categories.Add(newCategory);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(newCategory);
        }

        //Create To view Empty 
        [HttpGet]
        public IActionResult Edit(int id)
        {
            var category = _db.Categories.FirstOrDefault(c => c.CategoryId == id);
            return View(category);
        }


        //Create To Post 
        [HttpPost]
        public IActionResult Edit(Category newCategory) //string name , string description)
        {
            if (ModelState.IsValid)
            {
                var category = _db.Categories.FirstOrDefault(c => c.CategoryId == newCategory.CategoryId);
                category.Name = newCategory.Name;
                category.Description = newCategory.Description;
                _db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(newCategory);
        }

        [HttpGet]
        public IActionResult Delete(int id)
        {
            var category = _db.Categories.FirstOrDefault(c => c.CategoryId == id);
            return View(category);
        }


        //Create To Post 
        [HttpPost]
        [ActionName("Delete")]
        public IActionResult ConfirmDelete(int id) //string name , string description)
        {
            var category = _db.Categories.FirstOrDefault(c => c.CategoryId == id);
            _db.Categories.Remove(category);
            _db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}

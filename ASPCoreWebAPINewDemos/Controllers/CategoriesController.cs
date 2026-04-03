using Microsoft.AspNetCore.Mvc;

namespace ASPCoreWebAPINewDemos.Controllers
{
    //https://localhost:7015/api/Categories    verb get   
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        //DI Database Context
        private readonly AppDbContext _db;
        public CategoriesController(AppDbContext db)
        {
            _db = db;
        }
        //CRUD Operations
        //Get All Categories
        //https://localhost:7015/api/Categories
        [HttpGet]  //Return Status Code 200 Ok with List of Categories  Message (Model)  200(List)  404(NotFound)
        public IActionResult Get()
        {
            var categories = _db.Categories.ToList();
            if (categories == null || categories.Count == 0)
            {
                return NotFound();
            }
            return Ok(categories);
        }
        //Get By Id 
        //https://localhost:7015/api/Categories/1
        [HttpGet("{id:int}")]  //Return Status Code 200 Ok with List of Categories  Message (Model)  200(List)  404(NotFound)
        public IActionResult Get(int id)//binding Shap Data
        {
            //var category = _db.Categories.Find(id);
            var category = _db.Categories.FirstOrDefault(c => c.Id == id);
            if (category == null)
            {
                return NotFound();
            }
            return Ok(category);
        }
        //Post Create Category
        [HttpPost]
        public IActionResult Post(Category newCategory) // Model Bind //Complex Type Create By User
        {
            //Model Validation
            if (ModelState.IsValid)  // ModelState Dic Key , Value  id,Name,
            {
                //SaveDatabase
                _db.Categories.Add(newCategory);
                _db.SaveChanges();
                //return Created(); //201 Created without Location Header
                return CreatedAtAction(nameof(Get), new { id = newCategory.Id }, newCategory); //201 Created with Location Header
            }
            return BadRequest(ModelState); //400 Bad Request with ModelState Errors
        }
        //Put Update Category
        [HttpPut("{id:int}")]
        public IActionResult put([FromRoute] int id, [FromBody] Category newCategory) // Model Bind //Complex Type Create By User
        {
            if (id != newCategory.Id)
            {
                return BadRequest();
            }
            if (!CategoryExist(id))
            {
                return NotFound();
            }
            //Model Validation
            if (ModelState.IsValid)  // ModelState Dic Key , Value  id,Name,
            {
                _db.Entry(newCategory).State = EntityState.Modified;
                //var updateCategory = _db.Categories.Find(id);
                //updateCategory.Name = newCategory.Name;
                //updateCategory.Description = newCategory.Description;

                _db.SaveChanges();
                return NoContent(); //204 
            }
            return BadRequest(ModelState); //400 Bad Request with ModelState Errors
        }
        //Delete Category
        [HttpDelete("{id:int}")]
        public IActionResult Delete([FromRoute] int id) // Model Bind //Complex Type Create By User
        {
            var deleteCategory = _db.Categories.Find(id);
            if (deleteCategory == null)
            {
                return NotFound();
            }
            _db.Categories.Remove(deleteCategory);
            _db.SaveChanges();
            return NoContent(); //204 
        }
        private bool CategoryExist(int id)
        {
            return _db.Categories.Any(k => k.Id == id);
        }
    }
}

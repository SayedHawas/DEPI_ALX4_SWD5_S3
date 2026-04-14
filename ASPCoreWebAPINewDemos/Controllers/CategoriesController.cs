using Microsoft.AspNetCore.Mvc;

namespace ASPCoreWebAPINewDemos.Controllers
{
    //https://localhost:7015/api/Categories    verb get   
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        //private readonly IRepository<Category>_dbSetCategory;
        //private readonly IRepository<Product> _dbSetProduct;
        //DI Database Context
        //private readonly AppDbContext _db;

        private readonly IUnitOfWork _UOW;
        public CategoriesController(IUnitOfWork uOW)//, IRepository<Category> dbSetCategory, IRepository<Product> dbSetProduct )
        {
            _UOW = uOW;
            //_db = db;
            //_dbSetCategory = dbSetCategory;
            //_dbSetProduct = dbSetProduct;
        }
        //CRUD Operations
        //Get All Categories
        //https://localhost:7015/api/Categories
        [HttpGet]  //Return Status Code 200 Ok with List of Categories  Message (Model)  200(List)  404(NotFound)
        public IActionResult Get()
        {
            //_dbSetCategory.GetAll();

            //var categories = _db.Categories.ToList();
            var categories = _UOW.RepositoryCategories.GetAll();
            if (categories == null)//|| categories.Count == 0)
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
            //var category = _db.Categories.FirstOrDefault(c => c.CategoryId == id);
            var category = _UOW.RepositoryCategories.GetById(id);
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
                //_db.Categories.Add(newCategory);
                //_db.SaveChanges();
                _UOW.RepositoryCategories.Add(newCategory);
                //_UOW.Complete();
                //return Created(); //201 Created without Location Header
                return CreatedAtAction(nameof(Get), new { id = newCategory.CategoryId }, newCategory); //201 Created with Location Header
            }
            return BadRequest(ModelState); //400 Bad Request with ModelState Errors
        }
        //Put Update Category
        [HttpPut("{id:int}")]
        public IActionResult put([FromRoute] int id, [FromBody] Category newCategory) // Model Bind //Complex Type Create By User
        {
            if (id != newCategory.CategoryId)
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
                //_db.Entry(newCategory).State = EntityState.Modified;
                //var updateCategory = _db.Categories.Find(id);
                //updateCategory.Name = newCategory.Name;
                //updateCategory.Description = newCategory.Description;

                //_db.SaveChanges();
                _UOW.RepositoryCategories.Update(newCategory);
                _UOW.Complete();
                return NoContent(); //204 
            }
            return BadRequest(ModelState); //400 Bad Request with ModelState Errors
        }
        //Delete Category
        [HttpDelete("{id:int}")]
        public IActionResult Delete([FromRoute] int id) // Model Bind //Complex Type Create By User
        {
            //var deleteCategory = _db.Categories.Find(id);
            var deleteCategory = _UOW.RepositoryCategories.GetById(id);
            if (deleteCategory == null)
            {
                return NotFound();
            }
            //_db.Categories.Remove(deleteCategory);
            //_db.SaveChanges();
            _UOW.RepositoryCategories.Delete(id);
            _UOW.Complete();
            return NoContent(); //204 
        }
        private bool CategoryExist(int id)
        {
            //return _db.Categories.Any(k => k.CategoryId == id);
            return _UOW.RepositoryCategories.IsExist(id);
        }
    }
}

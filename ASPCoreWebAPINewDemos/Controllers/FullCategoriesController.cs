using Microsoft.AspNetCore.Mvc;

namespace ASPCoreWebAPINewDemos.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FullCategoriesController : ControllerBase
    {
        //DI Database Context
        private readonly AppDbContext _db;
        public FullCategoriesController(AppDbContext db)
        {
            _db = db;
        }
        //CRUD Operations
        //Get All Categories
        //https://localhost:7015/api/Categories
        [HttpGet]  //Return Status Code 200 Ok with List of Categories  Message (Model)  200(List)  404(NotFound)
        public async Task<ActionResult<IEnumerable<Category>>> Get()
        {
            var categories = await _db.Categories.AsNoTracking().ToListAsync();
            if (categories == null || categories.Count == 0)
            {
                return NotFound();
            }
            return Ok(categories);
        }
        //Get By Id 
        //https://localhost:7015/api/Categories/1
        [HttpGet("{id:int}")]  //Return Status Code 200 Ok with List of Categories  Message (Model)  200(List)  404(NotFound)
        public async Task<ActionResult<Category>> Get(int id)//binding Shap Data
        {
            //var category = _db.Categories.Find(id);
            var category = await _db.Categories.AsNoTracking().FirstOrDefaultAsync(c => c.Id == id);
            if (category == null)
            {
                return NotFound();
            }
            return Ok(category);
        }
        //Post Create Category
        [HttpPost]
        public async Task<IActionResult> Post(Category newCategory) // Model Bind //Complex Type Create By User
        {
            //Model Validation
            if (ModelState.IsValid)  // ModelState Dic Key , Value  id,Name,
            {
                //SaveDatabase
                await _db.Categories.AddAsync(newCategory);
                await _db.SaveChangesAsync();
                //return Created(); //201 Created without Location Header
                return CreatedAtAction(nameof(Get), new { id = newCategory.Id }, newCategory); //201 Created with Location Header
            }
            return BadRequest(ModelState); //400 Bad Request with ModelState Errors
        }
        //Put Update Category
        [HttpPut("{id:int}")]
        public async Task<IActionResult> put([FromRoute] int id, [FromBody] Category newCategory) // Model Bind //Complex Type Create By User
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

                await _db.SaveChangesAsync();
                return NoContent(); //204 
            }
            return BadRequest(ModelState); //400 Bad Request with ModelState Errors
        }
        //Delete Category
        [HttpDelete("{id:int}")]
        public async Task<IActionResult> Delete([FromRoute] int id) // Model Bind //Complex Type Create By User
        {
            var deleteCategory = await _db.Categories.FindAsync(id);
            if (deleteCategory == null)
            {
                return NotFound();
            }
            _db.Categories.Remove(deleteCategory);
            await _db.SaveChangesAsync();
            return NoContent(); //204 
        }
        private bool CategoryExist(int id)
        {
            return _db.Categories.Any(k => k.Id == id);
        }
    }
}

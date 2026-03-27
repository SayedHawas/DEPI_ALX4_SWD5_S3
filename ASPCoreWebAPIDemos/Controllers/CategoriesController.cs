using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ASPCoreWebAPIDemos.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CategoriesController : ControllerBase
    {
        //Connect to the database using dependency injection
        private readonly AppDbContext _db;
        public CategoriesController(AppDbContext db)
        {
            _db = db;
        }

        //CURD operations for categories
        //GET: api/categories
        [HttpGet]
        public IActionResult Get()  //ActionResult - IActionResult  return http Status code along with data
        {
            var categories = _db.Categories.ToList();
            return Ok(categories);
        }

        [HttpGet("{id:int}")] //,Name = "GetById")] //[Route("{id}")] Concat  on Controller Route this Placeholder            
        public IActionResult GetById(int id) // Model Binder (Primitive Route[Parameter Or Query string ] | Complex --> request body  )
        {
            var category = _db.Categories.FirstOrDefault(e => e.Id == id);
            if (category == null)
            {
                return NotFound();
            }
            return Ok(category);
        }
        [HttpGet("{name:alpha}")]
        public IActionResult GetByName(string name)
        {
            var category = _db.Categories.FirstOrDefault(e => e.Name.Equals(name));
            if (category == null)
            {
                return NotFound();
            }
            return Ok(category);
        }
        [HttpPost]
        public IActionResult Post(Category newCategory)
        {
            if (ModelState.IsValid)
            {
                _db.Categories.Add(newCategory);
                _db.SaveChanges();
                //return Created();
                return CreatedAtAction("GetById", new { id = newCategory.Id }, newCategory); //Location header with the URL of the newly created resource
            }
            return BadRequest(ModelState);
        }
        [HttpPut("{id}")]
        public IActionResult Put([FromRoute] int id, [FromBody] Category newCategory)
        {
            if (id != newCategory.Id)
            {
                return BadRequest();
            }
            if (!CategoryExists(id))
            {
                return NotFound();
            }
            try
            {
                _db.Entry(newCategory).State = EntityState.Modified;
                _db.SaveChanges();
                return Ok(newCategory);
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return BadRequest(ex);
            }
        }
        [HttpDelete("{id}")]
        public IActionResult DeleteEmployee([FromRoute] int id)
        {
            var deleteCategory = _db.Categories.FirstOrDefault(e => e.Id == id);
            if (deleteCategory == null)
            {
                return NotFound();
            }
            _db.Categories.Remove(deleteCategory);
            _db.SaveChanges();
            return NoContent();
        }
        private bool CategoryExists(int id)
        {
            return _db.Categories.Any(e => e.Id == id);
        }
    }
}

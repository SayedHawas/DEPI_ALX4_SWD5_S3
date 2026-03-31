using ASPCoreWebAPIDemos.DTOs.CategoryDtos;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ASPCoreWebAPIDemos.Controllers
{
    //https://localhost:7014/api/categories
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
        //https://localhost:7014/api/categories/MyCode?code=100
        [HttpGet("MyCode")]
        public IActionResult Get(int code)
        {
            return Ok($"Code {code}  ");
        }
        //https://localhost:7014/api/categories
        //CURD operations for categories
        //GET: api/categories
        [HttpGet]
        public IActionResult Get()  //ActionResult - IActionResult  return http Status code along with data
        {
            //var categories = _db.Categories.ToList();
            //return Ok(categories);

            var categories = _db.Categories.ToList();
            if (categories == null || categories.Count == 0)
            {
                return NotFound();
            }
            List<CategoryGetDto> categoryList = new List<CategoryGetDto>();
            foreach (var category in categories)
            {
                categoryList.Add(new CategoryGetDto
                {
                    Id = category.Id,
                    Name = category.Name,
                    Description = category.Description
                });
            }
            return Ok(categoryList);
        }
        //https://localhost:7014/api/categories/1
        //[Route("{id:int?}")]
        //[HttpGet]
        [HttpGet("{id:int}")] //,Name = "GetById")] //[Route("{id}")] Concat  on Controller Route this Placeholder            
        public IActionResult GetById(int id) // Model Binder (Primitive Route[Parameter Or Query string ] | Complex --> request body  )
        {
            //var category = _db.Categories.FirstOrDefault(e => e.Id == id);
            //if (category == null)
            //{
            //    return NotFound();
            //}
            //return Ok(category);

            var category = _db.Categories.FirstOrDefault(e => e.Id == id);
            if (category == null)
            {
                return NotFound();
            }
            CategoryGetDto categoryOne = new CategoryGetDto();
            categoryOne.Id = category.Id;
            categoryOne.Name = category.Name;
            categoryOne.Description = category.Description;

            return Ok(categoryOne);
        }
        //https://localhost:7014/api/categories/?name=Electronics
        [HttpGet("{name:alpha}")]
        public IActionResult GetByName(string name)
        {
            //var category = _db.Categories.FirstOrDefault(e => e.Name.Equals(name));
            //if (category == null)
            //{
            //    return NotFound();
            //}
            //return Ok(category);
            var category = _db.Categories.FirstOrDefault(e => e.Name.Equals(name));
            if (category == null)
            {
                return NotFound();
            }
            CategoryGetDto categoryOne = new CategoryGetDto();
            categoryOne.Id = category.Id;
            categoryOne.Name = category.Name;
            categoryOne.Description = category.Description;

            return Ok(categoryOne);
        }

        [HttpGet("GetProductsName")]
        public IActionResult GetWithProductsName()  //ActionResult - IActionResult  return http Status code along with data
        {
            //var categories = _db.Categories.ToList();
            //return Ok(categories);

            var categories = _db.Categories.Include("Products").ToList();
            if (categories == null || categories.Count == 0)
            {
                return NotFound();
            }
            List<CategoryGetWithProductsNamesDto> categoryList = new List<CategoryGetWithProductsNamesDto>();
            foreach (var category in categories)
            {
                categoryList.Add(new CategoryGetWithProductsNamesDto
                {
                    Id = category.Id,
                    Name = category.Name,
                    Description = category.Description,
                    ProductsName = category.Products.Select(p => p.Name).ToList()
                });
            }
            return Ok(categoryList);
        }


        //https://localhost:7014/api/categories
        [HttpPost]
        public IActionResult Post(CategoryCreateDto newCategory)  //(Category newCategory)
        {
            //var error = ModelState.ErrorCount;
            if (ModelState.IsValid)
            {
                Category category = new Category
                {
                    Id = newCategory.Id,
                    Name = newCategory.Name,
                    Description = newCategory.Description
                };

                _db.Categories.Add(category);
                _db.SaveChanges();
                //return Created();
                return CreatedAtAction("GetById", new { id = category.Id }, category); //Location header with the URL of the newly created resource
            }
            return BadRequest(ModelState);
        }
        [HttpPut("{id}")]
        public IActionResult Put([FromRoute] int id, [FromBody] CategoryCreateDto newCategory) //[FromBody] Category newCategory)
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
                if (ModelState.IsValid)
                {
                    Category category = _db.Categories.FirstOrDefault(e => e.Id == id);
                    category.Name = newCategory.Name;
                    category.Description = newCategory.Description;
                    //_db.Entry(newCategory).State = EntityState.Modified;
                    _db.SaveChanges();
                    return Ok(newCategory);
                }
                return BadRequest(ModelState);
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

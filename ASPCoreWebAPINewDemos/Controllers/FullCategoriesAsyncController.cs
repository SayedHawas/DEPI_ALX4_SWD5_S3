using ASPCoreWebAPINewDemos.DTOS.CategoryDtos;
using Microsoft.AspNetCore.Mvc;

namespace ASPCoreWebAPINewDemos.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FullCategoriesAsyncController : ControllerBase
    {
        private readonly AppDbContext _context;

        public FullCategoriesAsyncController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/FullCategoriesAsync
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CategoryGetDto>>> GetCategories()
        {
            //Select From DB
            var list = await _context.Categories.Include("Products").AsNoTracking().ToListAsync();
            if (list == null || list.Count == 0)
            {
                return NotFound();
            }
            List<CategoryGetDto> categoryGetDtos = new List<CategoryGetDto>();
            foreach (var item in list)
            {
                var categoryGetDto = new CategoryGetDto
                {
                    CategoryId = item.CategoryId,
                    Name = item.Name,
                    Description = item.Description,
                    ProductNames = item.Products?.Select(p => p.Name).ToList()
                };
                categoryGetDtos.Add(categoryGetDto);
            }
            return Ok(categoryGetDtos);
        }

        // GET: api/FullCategoriesAsync/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CategoryGetDto>> GetCategory(int id)
        {
            //var category = await _context.Categories.FindAsync(id);
            //if (category == null)
            //{
            //    return NotFound();
            //}
            //return category;
            //Select From DB
            var category = await _context.Categories.Include("Products").AsNoTracking().FirstOrDefaultAsync(c => c.CategoryId == id); //.FindAsync(id);
            if (category == null)
            {
                return NotFound();
            }
            var categoryGetDto = new CategoryGetDto
            {
                CategoryId = category.CategoryId,
                Name = category.Name,
                Description = category.Description,
                ProductNames = category.Products.Select(p => p.Name).ToList()
            };
            return Ok(categoryGetDto);
        }

        // PUT: api/FullCategoriesAsync/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCategory(int id, CategoryPutDto newCategory) //Category category)
        {
            if (id != newCategory.CategoryId)
            {
                return BadRequest("Not Same ID ...");
            }
            if (!CategoryExists(id)) return NotFound();
            //validation
            if (ModelState.IsValid)
            {
                var category = await _context.Categories.FindAsync(id);
                category.Name = newCategory.Name;
                category.Description = newCategory.Description;
                _context.Entry(category).State = EntityState.Modified;
                await _context.SaveChangesAsync();
                return NoContent();
            }
            return BadRequest(ModelState);
        }

        // POST: api/FullCategoriesAsync
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CategoryPostDto>> PostCategory(CategoryPostDto newCategory) //(Category category)
        {
            //Validation Model Bind + Model State Dictionary Key Value Pairs Name
            if (ModelState.IsValid)
            {
                var category = new Category
                {
                    Name = newCategory.Name,
                    Description = newCategory.Description
                };
                _context.Categories.Add(category);
                await _context.SaveChangesAsync();
                return CreatedAtAction("GetCategory", new { id = category.CategoryId }, category);
            }
            return BadRequest(ModelState);
        }

        // DELETE: api/FullCategoriesAsync/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
            var category = await _context.Categories.FindAsync(id);
            if (category == null)
            {
                return NotFound();
            }
            _context.Categories.Remove(category);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool CategoryExists(int id)
        {
            return _context.Categories.Any(e => e.CategoryId == id);
        }
    }
}

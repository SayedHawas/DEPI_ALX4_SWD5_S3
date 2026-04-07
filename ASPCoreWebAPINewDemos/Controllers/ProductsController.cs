using ASPCoreWebAPINewDemos.DTOS.ProductDtos;
using Microsoft.AspNetCore.Mvc;

namespace ASPCoreWebAPINewDemos.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        private readonly AppDbContext _context;

        public ProductsController(AppDbContext context)
        {
            _context = context;
        }
        // GET: api/Products
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ProductGetDto>>> GetProducts()
        {
            var list = await _context.Products.Include("Category").AsNoTracking().ToListAsync();
            if (list == null || list.Count == 0)
            {
                return NotFound();
            }
            List<ProductGetDto> productGetDtos = list.Select(p => new ProductGetDto
            {
                ProductId = p.ProductId,
                Name = p.Name,
                Price = p.Price,
                Description = p.Description,
                PhotoPathUrl = p.PhotoPathUrl,
                CategoryName = p.Category.Name
            }).ToList();
            return Ok(productGetDtos);
        }
        // GET: api/Products/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Product>> GetProduct(int id)
        {
            //var product = await _context.Products.FindAsync(id);
            //if (product == null)
            //{
            //    return NotFound();
            //}
            //return product;
            var product = await _context.Products.Include("Category").FirstOrDefaultAsync(p => p.ProductId == id);
            if (product == null)
            {
                return NotFound();
            }
            ProductGetDto productGetDto = new ProductGetDto
            {
                ProductId = product.ProductId,
                Name = product.Name,
                Price = product.Price,
                Description = product.Description,
                PhotoPathUrl = product.PhotoPathUrl,
                CategoryName = product.Category.Name
            };
            return Ok(productGetDto);
        }

        // PUT: api/Products/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutProduct(int id, ProductPostDto newProduct) // Product product)
        {
            if (id != newProduct.ProductId)
            {
                return BadRequest();
            }
            if (!ProductExists(id)) return NotFound();
            if (ModelState.IsValid)
            {
                Product product = new Product()
                {
                    ProductId = newProduct.ProductId,
                    Name = newProduct.Name,
                    Description = newProduct.Description,
                    Price = newProduct.Price,
                    PhotoPathUrl = "E:\\new\\product.png",
                    CategoryId = newProduct.CategoryId
                };
                try
                {
                    _context.Entry(product).State = EntityState.Modified;
                    await _context.SaveChangesAsync();
                    return NoContent();
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    return BadRequest(ex.Message);
                }
            }
            return BadRequest(ModelState);
        }

        // POST: api/Products
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<IActionResult> PostProduct([FromBody] ProductPostDto newProduct) //(Product product)
        {
            if (ModelState.IsValid)
            {
                Product product = new Product
                {
                    Name = newProduct.Name,
                    Price = newProduct.Price,
                    Description = newProduct.Description,
                    PhotoPathUrl = "E:\\new\\product.png",  //Fix Path
                    CategoryId = newProduct.CategoryId
                };
                try
                {
                    _context.Products.Add(product);
                    await _context.SaveChangesAsync();
                    return CreatedAtAction("GetProduct", new { id = product.ProductId }, product);
                }
                catch (Microsoft.EntityFrameworkCore.DbUpdateConcurrencyException)
                {
                    return BadRequest("Fail Create ....");
                }
            }
            return BadRequest(ModelState);
        }

        // DELETE: api/Products/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }

            _context.Products.Remove(product);
            await _context.SaveChangesAsync();

            return NoContent();
        }
        private bool ProductExists(int id)
        {
            return _context.Products.Any(e => e.ProductId == id);
        }
    }
}

using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ASPCoreWebAPIDemos.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductsController : ControllerBase
    {
        //Connect to the database using dependency injection
        private readonly AppDbContext _db;
        public ProductsController(AppDbContext db)
        {
            _db = db;
        }
        [HttpGet]
        public IActionResult Get()
        {
            var products = _db.Products.Include("Category").ToList();
            if (products == null || products.Count == 0)
            {
                return NotFound();
            }
            List<ProductsGetDto> productsList = new List<ProductsGetDto>();
            foreach (var product in products)
            {
                productsList.Add(new ProductsGetDto
                {
                    Id = product.Id,
                    Name = product.Name,
                    Price = product.Price,
                    Description = product.Description,
                    ImagePath = product.ImagePath,
                    CategoryName = product.Category.Name
                });
            }
            return Ok(productsList);
        }

        [HttpGet("{id:int}")]
        public IActionResult Get(int id)
        {
            var product = _db.Products.Include("Category").FirstOrDefault(p => p.Id == id);
            if (product == null)
            {
                return NotFound();
            }
            ProductsGetDto productOne = new ProductsGetDto();
            productOne.Id = product.Id;
            productOne.Name = product.Name;
            productOne.Price = product.Price;
            productOne.Description = product.Description;
            productOne.ImagePath = product.ImagePath;
            productOne.CategoryName = product.Category.Name;

            return Ok(productOne);
        }
    }
}
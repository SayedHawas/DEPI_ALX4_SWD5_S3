namespace ASPCoreWebAPIDemos.DTOs.ProductDtos
{
    public class ProductsGetDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string? Description { get; set; }
        public string? ImagePath { get; set; }
        public string CategoryName { get; set; }
    }
}

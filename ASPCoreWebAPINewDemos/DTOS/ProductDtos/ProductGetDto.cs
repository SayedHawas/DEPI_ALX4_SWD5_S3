namespace ASPCoreWebAPINewDemos.DTOS.ProductDtos
{
    public class ProductGetDto
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public string? Description { get; set; } = string.Empty;
        public string? PhotoPathUrl { get; set; } = string.Empty;
        public string CategoryName { get; set; }
    }
}

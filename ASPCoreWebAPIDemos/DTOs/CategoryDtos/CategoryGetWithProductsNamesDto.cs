namespace ASPCoreWebAPIDemos.DTOs.CategoryDtos
{
    public class CategoryGetWithProductsNamesDto : CategoryGetDto
    {
        public List<string>? ProductsName { get; set; }
    }
}

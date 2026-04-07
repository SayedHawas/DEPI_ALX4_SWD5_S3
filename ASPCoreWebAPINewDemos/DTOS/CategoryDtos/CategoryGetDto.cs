namespace ASPCoreWebAPINewDemos.DTOS.CategoryDtos
{
    public class CategoryGetDto
    {
        public int CategoryId { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public List<string>? ProductNames { get; set; }
    }
}

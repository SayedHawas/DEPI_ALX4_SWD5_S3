using System.ComponentModel.DataAnnotations;

namespace ASPCoreWebAPINewDemos.DTOS.CategoryDtos
{
    public class CategoryPostDto
    {
        [Required]
        [StringLength(100, MinimumLength = 5)]
        public string Name { get; set; }
        [MaxLength(500)]
        public string? Description { get; set; }
    }
}

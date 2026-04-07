using System.ComponentModel.DataAnnotations;

namespace ASPCoreWebAPINewDemos.DTOS.CategoryDtos
{
    public class CategoryPutDto : CategoryPostDto
    {
        [Required]
        public int CategoryId { get; set; }
    }
}

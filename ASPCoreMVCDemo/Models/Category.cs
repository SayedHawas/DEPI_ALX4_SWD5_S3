using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ASPCoreMVCDemo.Models
{
    public class Category : BaseEntity
    {
        [Key]
        public int CategoryId { get; set; }
        [DisplayName("Full Name")]
        [Required(ErrorMessage = "Category name is required.")]
        [StringLength(50, ErrorMessage = "Category name cannot exceed 50  and less than 5 characters.", MinimumLength = 5)]
        public string Name { get; set; }
        [MaxLength(200, ErrorMessage = "Description cannot exceed 200 characters.")]
        public string? Description { get; set; }
        public virtual ICollection<Product>? Products { get; set; }
    }
}

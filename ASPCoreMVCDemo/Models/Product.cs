using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ASPCoreMVCDemo.Models
{
    public class Product : BaseEntity
    {
        [Key]
        public int ProductId { get; set; }
        [Required(ErrorMessage = "Product name is required.")]
        [StringLength(100, ErrorMessage = "Product name cannot exceed 100 characters.", MinimumLength = 5)]
        public string Name { get; set; }
        [Required(ErrorMessage = "Price is required.")]
        [Column(TypeName = "decimal(9,2)")]   // Adjust precision and scale as needed   1234567,99
        public decimal Price { get; set; }
        [StringLength(255, ErrorMessage = "Image path cannot exceed 255 characters.")]
        public string? ImagePath { get; set; }

        [ForeignKey("Category")]
        public int CategoryId { get; set; }
        public virtual Category? Category { get; set; }
    }
}

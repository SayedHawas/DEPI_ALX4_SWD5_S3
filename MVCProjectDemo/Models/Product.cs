using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MVCProjectDemo.Models
{
    public class Product
    {
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "Name is required")]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "Name must be between 3 and 100 characters")]
        public string Name { get; set; }
        [MaxLength(300, ErrorMessage = "Description cannot exceed 300 characters")]
        public string? Description { get; set; }
        [Required(ErrorMessage = "Price is required")]
        [Column(TypeName = "decimal(9,2)")]
        [Range(0.01, 9999999.99, ErrorMessage = "Price must be between 0.01 and 9999999.99")]
        public decimal Price { get; set; }

        [ForeignKey("Category")]
        public int CategoryId { get; set; }
        public Category Category { get; set; }

    }
}

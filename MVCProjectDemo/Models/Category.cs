using System.ComponentModel.DataAnnotations;

namespace MVCProjectDemo.Models
{
    public class Category
    {
        //Data Annotations 
        //1- Create Database 
        //2- Validation
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "Name is required")]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "Name must be between 3 and 100 characters")]
        public string Name { get; set; }
        [MaxLength(300, ErrorMessage = "Description cannot exceed 300 characters")]
        public string? Description { get; set; }

        public ICollection<Product>? Products { get; set; }
    }
}

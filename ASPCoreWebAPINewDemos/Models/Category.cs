using System.ComponentModel.DataAnnotations;

namespace ASPCoreWebAPINewDemos.Models
{
    public class Category
    {
        //DataAnnotations are used to specify validation rules and constraints for the properties of the Category class.
        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 5)]
        public string Name { get; set; }
        [MaxLength(500)]
        public string? Description { get; set; }
    }
}

using System.ComponentModel.DataAnnotations;

namespace ASPCoreWebAPINewDemos.Models
{
    public class Category  //: BaseEntity
    {
        //DataAnnotations are used to specify validation rules and constraints for the properties of the Category class.
        [Key]
        public int CategoryId { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 5)]
        public string Name { get; set; }
        [MaxLength(500)]
        public string? Description { get; set; }


        //Navigation property to represent the relationship between Category and Product. It indicates that a category can have multiple products associated with it.
        public virtual ICollection<Product> Products { get; set; } = new HashSet<Product>();
    }
}

using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ASPCoreWebAPINewDemos.Models
{
    public class Product
    {
        [Key]
        public int ProductId { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 5)] //Validation attribute to ensure the name is between 5 and 100 characters
        public string Name { get; set; }
        [Required]
        [Range(0.99, 9999999.99, ErrorMessage = "Price must be greater than zero.")] //Validation attribute to ensure the price is a positive value
        [Column(TypeName = "decimal(9,2)")] //Specify the precision and scale for the decimal type in the database
        public decimal Price { get; set; }
        [MaxLength(500)]
        public string? Description { get; set; } = string.Empty;
        [MaxLength(255)]
        public string? PhotoPathUrl { get; set; } = string.Empty;
        [NotMapped] //This attribute indicates that the Photo property should not be mapped to a database column
        [JsonIgnore]
        public IFormFile Photo { get; set; }

        [ForeignKey("Category")] //This attribute specifies that the CategoryId property is a foreign key that references the Category entity.
        public int CategoryId { get; set; }
        //Navigation property to represent the relationship between Product and Category. It indicates that a product belongs to a single category.
        public Category Category { get; set; }


        //public DateOnly DayOfBirth { get; set; }
        //[NotMapped]
        //public int Age { get; set; }

    }
}

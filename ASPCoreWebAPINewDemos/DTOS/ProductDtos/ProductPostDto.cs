using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ASPCoreWebAPINewDemos.DTOS.ProductDtos
{
    public class ProductPostDto
    {
        [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingDefault)]
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
        public string? Photo { get; set; }
        [Required]
        public int CategoryId { get; set; }
    }
}

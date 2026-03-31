using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ASPCoreWebAPIDemos.Models
{
    public class Product
    {
        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(100, MinimumLength = 10)]
        public string Name { get; set; }
        [Column(TypeName = "decimal(18,2)")]
        [Range(typeof(decimal), "1000.99", "10000.99")]
        [Required]
        public decimal Price { get; set; }
        [StringLength(500)]
        public string? Description { get; set; }
        [NotMapped]
        //[JsonIgnore]
        public byte[]? Image { get; set; }
        [StringLength(255)]
        public string? ImagePath { get; set; }

        [ForeignKey("Category")]
        public int CategoryId { get; set; }
        //Navigation property
        public virtual Category Category { get; set; }
    }
}

/*
 [Key]
public int Id { get; set; }

[Required]
[StringLength(50, ErrorMessage = "up to 50 characters only")]
public string Name { get; set; }

[DisplayFormat(DataFormatString = "{0:P}")]
public decimal Score { get; set; }
[StringLength(10, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
public string Code { get; set; }

[Range(17, 21, ErrorMessage = "between 17 and 21")]
public int Age { get; set; }

[RegularExpression("^[a-zA-Z]{6}$", ErrorMessage = "Enter 6  Letter only ")]
public string Group { get; set; }

[DataType(DataType.MultilineText)]
public string Notes { get; set; } = string.Empty;
[DataType(DataType.EmailAddress)]
public string Email { get; set; } = string.Empty;

[IgnoreDataMember]
[FileExtensions(Extensions = ".jpg,.gif")]
public byte[]? PhotoFile { get; set; }

public string? Photo { get; set; }

[DataType(DataType.DateTime)]
[DisplayFormat(DataFormatString = "{0:MM/dd/YYYY}", ApplyFormatInEditMode = true)]
//public Nullable<System.DateTime> CreateDate { get; set; }
public DateTime? CreateDate { get; set; }

[Range(typeof(decimal), "1000.50", "100000.50")]
[CreditCard]
public decimal Credit { get; set; }
 */
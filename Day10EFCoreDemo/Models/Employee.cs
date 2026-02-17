using System.ComponentModel.DataAnnotations;  // For Data Annotations attributes
using System.ComponentModel.DataAnnotations.Schema;
namespace Day10EFCoreDemo.Models
{
    [Table("TblEmployees")]  // Optional: specify table name, otherwise it will be "Employees" by convention)]
    public class Employee      //Entry Row
    {
        [Key]
        public int EmployeeId { get; set; }  // Primary Key property + Identity, convention-based
        [Required]
        [MaxLength(100)]
        public string Name { get; set; }    //nvarchar(max) by default --> nvarchar(100) due to MaxLength attribute
        [DataType(DataType.Currency)]
        public decimal Salary { get; set; }
        [Required]
        [MaxLength(100)]
        public string Job { get; set; }
        [MaxLength(150)]
        [DataType(DataType.EmailAddress)]
        public string? Email { get; set; }
        [DataType(DataType.Date)]
        public DateTime? DateOfBirth { get; set; }

        [MaxLength(500)]
        public string? Address { get; set; }
        [NotMapped]
        public int Age { get; set; }


        public override string ToString()
        {
            //  return base.ToString();
            return $"EmployeeId: {EmployeeId}, Name: {Name}, Salary: {Salary}, Job: {Job}, Email: {Email}, DateOfBirth: {DateOfBirth?.ToShortDateString()}, Address: {Address}";
        }
    }
}

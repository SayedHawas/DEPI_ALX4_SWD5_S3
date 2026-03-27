using System.ComponentModel.DataAnnotations.Schema;

namespace ASPCoreWebAPIDBFirst.Models
{
    public partial class Employee
    {
        [NotMapped]
        public string imagePath { get; set; }
        public override string ToString()
        {
            return $" {FirstName} {LastName}";  //base.ToString();
        }
    }
}

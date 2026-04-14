using System.ComponentModel.DataAnnotations;

namespace ASPCoreWebAPINewDemos.Models
{
    public class Demo
    {
        [Key]  //Id Primary Key 
        public Guid Id { get; set; } = new Guid(); //

    }

    public class RepoDemo
    {
        public Demo GetByID(Guid Id)
        {
            return new Demo() { Id = Id };
        }
    }
}


namespace ASPCoreWebAPINewDemos.Models
{
    public class BaseEntity : IBaseEntity
    {
        public bool isDeleted { get; set; } = false;
        public int CreateId { get; set; } = 1;
        public DateTime CreateDate { get; set; } = DateTime.Now;
        public int UpdateId { get; set; } = 1;
        public DateTime UpdateDate { get; set; } = DateTime.Now;
    }
}

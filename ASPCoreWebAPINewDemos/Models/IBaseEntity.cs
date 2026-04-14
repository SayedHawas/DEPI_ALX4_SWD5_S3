namespace ASPCoreWebAPINewDemos.Models
{
    public interface IBaseEntity
    {
        bool isDeleted { get; set; }
        int CreateId { get; set; }
        DateTime CreateDate { get; set; }
        int UpdateId { get; set; }
        DateTime UpdateDate { get; set; }
    }
}

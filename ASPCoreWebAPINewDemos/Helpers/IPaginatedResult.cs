namespace ASPCoreWebAPINewDemos.Helpers
{
    public interface IPaginatedResult<T> : IEnumerable<T> where T : class
    {
        IEnumerable<T> Data { get; set; }
        int TotalCount { get; set; }
        int PageNumber { get; set; }
        int PageSize { get; set; }
    }
}

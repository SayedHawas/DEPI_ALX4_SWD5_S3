using ASPCoreWebAPINewDemos.Helpers;

namespace ASPCoreWebAPINewDemos.Repositories.Interfaces
{
    public interface IExtraRepository<T> : IRepository<T> where T : class
    {
        int RowsCount();
        int MaxId();
        PaginatedResult<T> GetAllPaginationWithData(int pageNumber = 1, int pageSize = 10);
    }
}

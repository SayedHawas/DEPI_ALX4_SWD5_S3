using ASPCoreWebAPINewDemos.Helpers;

namespace ASPCoreWebAPINewDemos.Repositories.Interfaces
{
    public interface IExtraRepository<T> where T : class
    {
        int RowsCount();
        int MaxId();
        IQueryable<T> GetAllPagination(int pageNumber = 1, int pageSize = 10);
        PaginatedResult<T> GetAllPaginationWithData(int pageNumber = 1, int pageSize = 10);
    }
}

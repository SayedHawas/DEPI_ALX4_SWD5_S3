using System.Collections;

namespace ASPCoreWebAPINewDemos.Helpers
{
    public class PaginatedResult<T> : IPaginatedResult<T> where T : class
    {
        public IEnumerable<T> Data { get; set; }
        public int TotalCount { get; set; }
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public IEnumerator<T> GetEnumerator()
        {
            //foreach (var item in Data)
            //{
            //    yield return item;
            //}
            for (int i = 0; i < Data.Count(); i++)
            {
                yield return Data.ElementAt(i);
            }
        }
        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
    }
}

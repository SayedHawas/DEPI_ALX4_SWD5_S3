using System.Linq.Expressions;

namespace ASPCoreWebAPINewDemos.Repositories.Interfaces
{
    //public interface IRepository<T,Tkey> where T : class
    public interface IRepository<T> where T : class
    {
        //CRUD Operations
        // T = Class Category , Tkey = int or string or GUID
        //T GetById(Tkey id);  // GUID can also be used based on the requirement

        //async programming
        //Task<IEnumerable<T>> GetAll();
        //Task Add(T entity);

        IEnumerable<T> GetAll();
        T GetById(int id);
        void Add(T entity);
        void Update(T entity);
        void Delete(int id);
        //Search( c=>c.Name == "John")  // Expression<Func<T, bool>> predicate
        IEnumerable<T> Search(Expression<Func<T, bool>> predicate);
        IEnumerable<T> GetAllWithIncluding(params string[] including);
        bool IsExist(int id);
    }
}

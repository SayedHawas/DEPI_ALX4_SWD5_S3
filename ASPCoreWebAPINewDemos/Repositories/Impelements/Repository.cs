using System.Linq.Expressions;

namespace ASPCoreWebAPINewDemos.Repositories.Impelements
{
    //public class Repository<T,Tkey> : IRepository<T,Tkey> where T : class
    public class Repository<T> : IRepository<T> where T : class
    {
        // This is a generic repository implementation that provides basic CRUD operations for any entity type T.
        // AppDbContext _context;
        private readonly AppDbContext _context; // ? DbSet<Category>  _context = UntiOfWork.Context
        private readonly DbSet<T> _dbSet; // ? DbSet<Category>
        public Repository(AppDbContext context)
        {
            _context = context;
            _dbSet = _context.Set<T>();
        }
        public IEnumerable<T> GetAll()
        {
            return _dbSet.AsNoTracking().ToList();
        }
        public T GetById(int id)
        {
            //return _dbSet.Find(id);

            //return _dbSet.AsNoTracking().FirstOrDefault(e => EF.Property<int>(e, "Id") == id);

            var keyName = _context.Model.FindEntityType(typeof(T)).FindPrimaryKey().Properties.Select(x => x.Name).Single();
            return _dbSet.AsNoTracking().FirstOrDefault(e => EF.Property<int>(e, keyName) == id);
        }
        public void Add(T entity)
        {
            _dbSet.Add(entity);
            //_context.SaveChanges();
        }
        public void Update(T entity)
        {
            //_context.Entry(entity).State = EntityState.Modified;
            _dbSet.Update(entity);
            //_context.SaveChanges();
        }
        public void Delete(int id)
        {
            var entity = _dbSet.Find(id);
            if (entity != null)
            {
                _dbSet.Remove(entity);
                //_context.SaveChanges();
            }
        }
        public IEnumerable<T> GetAllWithIncluding(params string[] including) //"Product","Client"
        {
            //_context.category.Include("Products").ToList();
            IQueryable<T> query = _dbSet.AsNoTracking();
            foreach (var include in including)
            {
                query = query.Include(include);
            }
            return query.ToList();
        }
        public IEnumerable<T> Search(Expression<Func<T, bool>> predicate)
        {
            var result = _dbSet.Where(predicate).AsNoTracking().ToList();
            return result;
        }
        public bool IsExist(int id)
        {
            var keyName = _context.Model.FindEntityType(typeof(T)).FindPrimaryKey().Properties.Select(x => x.Name).Single();
            return _dbSet.AsNoTracking().Any(e => EF.Property<int>(e, keyName) == id);
        }
    }
}

using ASPCoreWebAPINewDemos.Helpers;
using System.Linq.Expressions;

namespace ASPCoreWebAPINewDemos.Repositories.Impelements
{
    public class ExtraRepository<T> : IRepository<T>, IExtraRepository<T> where T : class
    {
        private readonly AppDbContext _context; // ? DbSet<Category>  _context = UntiOfWork.Context
        private readonly DbSet<T> _dbSet; // ? DbSet<Category>
        public ExtraRepository(AppDbContext context)
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
            _context.SaveChanges();
        }
        public void Update(T entity)
        {
            //_context.Entry(entity).State = EntityState.Modified;
            _dbSet.Update(entity);
            _context.SaveChanges();
        }
        public void Delete(int id)
        {
            var entity = _dbSet.Find(id);
            if (entity != null)
            {
                _dbSet.Remove(entity);
                _context.SaveChanges();
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
        public int RowsCount()
        {
            return _dbSet.AsNoTracking().Count();
        }
        public int MaxId()
        {
            var keyName = _context.Model.FindEntityType(typeof(T)).FindPrimaryKey().Properties.Select(x => x.Name).Single();
            return _dbSet.AsNoTracking().Max(e => EF.Property<int>(e, keyName));
        }

        public PaginatedResult<T> GetAllPaginationWithData(int pageNumber = 1, int pageSize = 10)
        {
            //Pagination SQL OffSet Fetch     Skip Take
            //Get totalNumber Of Rows 
            var TotalRows = _dbSet.AsNoTracking().Count();
            //calculate total number of pages
            var TotalPages = (int)Math.Ceiling((double)TotalRows / pageSize);  // 100.1 => 101

            //Query
            var query = _dbSet.AsNoTracking()
                .Skip(pageNumber - 1 * pageSize)
                .Take(pageSize);

            var result = new PaginatedResult<T>
            {
                Data = query.ToList(),
                TotalCount = TotalRows,
                PageNumber = pageNumber,
                PageSize = pageSize
            };
            return result;
        }
        public bool IsExist(int id)
        {
            var keyName = _context.Model.FindEntityType(typeof(T)).FindPrimaryKey().Properties.Select(x => x.Name).Single();
            return _dbSet.AsNoTracking().Any(e => EF.Property<int>(e, keyName) == id);
        }
        public IQueryable<T> GetAllPagination(int pageNumber = 1, int pageSize = 10) //1000 / 10 = 100 Pages
        {
            //Pagination SQL OffSet Fetch     Skip Take
            //Get totalNumber Of Rows 
            var TotalRows = _dbSet.AsNoTracking().Count();
            //calculate total number of pages
            var TotalPages = (int)Math.Ceiling((double)TotalRows / pageSize);  // 100.1 => 101

            //Query
            var query = _dbSet.AsNoTracking()
                .Skip(pageNumber - 1 * pageSize)
                .Take(pageSize);

            return query;
        }

        public T GetByIDWithIncluding(int id, params string[] including)
        {
            //get Id Name 
            var keyName = _context.Model.FindEntityType(typeof(T)).FindPrimaryKey().Properties.Select(x => x.Name).Single();

            IQueryable<T> query = _dbSet.AsNoTracking();
            foreach (var include in including)
            {
                query = query.Include(include);
            }
            //query
            var Result = query.FirstOrDefault(e => EF.Property<int>(e, keyName) == id);
            return Result;
        }
    }
}

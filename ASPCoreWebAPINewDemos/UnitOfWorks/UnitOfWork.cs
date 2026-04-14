


namespace ASPCoreWebAPINewDemos.UnitOfWorks
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly AppDbContext _context;
        public IRepository<Category> RepositoryCategories { get; }
        public IRepository<Product> RepositoryProducts { get; }

        public UnitOfWork(AppDbContext context,
            IRepository<Category> repoCategory,
            IRepository<Product> repoProduct)
        {
            _context = context;
            RepositoryCategories = repoCategory;
            RepositoryProducts = repoProduct;
            // RepositoryCategories = new Repository<Category>(_context);
            // RepositoryProducts = new Repository<Product>(_context);
        }
        public int Complete()
        {
            var rows = _context.SaveChanges();
            return rows;
        }
    }
}

namespace ASPCoreWebAPINewDemos.UnitOfWorks
{
    public interface IUnitOfWork
    {
        // This interface defines a contract for a unit of work, which is a design pattern that helps manage database transactions and coordinate the work of multiple repositories.
        // It provides properties for accessing repositories for different entity types (e.g., Category, Product) and a method to save changes to the database.
        IExtraRepository<Category> RepositoryCategories { get; }
        IRepository<Product> RepositoryProducts { get; }
        int Complete(); // This method is responsible for saving changes to the database and returning the number of affected records.
    }
}

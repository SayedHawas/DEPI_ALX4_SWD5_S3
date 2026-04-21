namespace ASPCoreWebAPINewDemos.Repositories
{
    public interface IRepos
    {
        List<Category> GetCategories();
        public List<Product> GetProducts()
        {
            return null;
        }
    }
}
// CLass : AbstractClass , Interface ,interface : Contract 
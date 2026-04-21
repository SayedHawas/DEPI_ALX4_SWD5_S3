namespace ASPCoreWebAPINewDemos.Services
{
    public class ServiceCategory : IServiceCategory
    {
        private readonly IUnitOfWork _UOW;
        public ServiceCategory(IUnitOfWork uOW)
        {
            _UOW = uOW;
        }
        public IEnumerable<CategoryGetDto> GetList()
        {
            // Return Data From Repository using Unit of Work
            var categories = _UOW.RepositoryCategories.GetAllWithIncluding("Products"); //.GetAll();
            //Mapping from Category to CategoryGetDto
            List<CategoryGetDto> categoriesResult = categories.Select(c => new CategoryGetDto
            {
                CategoryId = c.CategoryId,
                Name = c.Name,
                Description = c.Description,
                ProductNames = c.Products?.Select(p => p.Name).ToList()
            }).ToList();

            if (categoriesResult == null || categoriesResult.Count == 0)
            {
                return null;
            }
            return categoriesResult;
        }
        public CategoryGetDto GetCategory(int id)
        {
            var category = _UOW.RepositoryCategories.GetByIDWithIncluding(id, "Products");//.GetById(id);
            CategoryGetDto categoryResult = new CategoryGetDto
            {
                CategoryId = category.CategoryId,
                Name = category.Name,
                Description = category.Description,
                ProductNames = category.Products?.Select(p => p.Name).ToList()
            };
            if (category == null)
            {
                return null;
            }
            return categoryResult;
        }
        public void AddCategory(CategoryPostDto newCategory)
        {
            var category = new Category
            {
                Name = newCategory.Name,
                Description = newCategory.Description
            };
            _UOW.RepositoryCategories.Add(category);
            _UOW.Complete();
        }
        public void DeleteCategory(int id)
        {
            throw new NotImplementedException();
        }
        public void UpdateCategory(CategoryPutDto category)
        {
            throw new NotImplementedException();
        }

        public int GetMax()
        {
            return _UOW.RepositoryCategories.MaxId();
        }
    }
}

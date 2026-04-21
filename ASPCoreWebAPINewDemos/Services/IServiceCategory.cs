

namespace ASPCoreWebAPINewDemos.Services
{
    public interface IServiceCategory
    {
        IEnumerable<CategoryGetDto> GetList();
        void AddCategory(CategoryPostDto category);
        void UpdateCategory(CategoryPutDto category);
        void DeleteCategory(int id);
        CategoryGetDto GetCategory(int id);
        int GetMax();
    }
}

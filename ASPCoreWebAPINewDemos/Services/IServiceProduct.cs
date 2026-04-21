using ASPCoreWebAPINewDemos.DTOS.ProductDtos;

namespace ASPCoreWebAPINewDemos.Services
{
    public interface IServiceProduct
    {
        IEnumerable<ProductGetDto> GetList();
    }
}
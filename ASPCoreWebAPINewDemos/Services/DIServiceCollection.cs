namespace ASPCoreWebAPINewDemos.Services
{
    public static class DIServiceCollection
    {
        public static void AddServicesForServiceLayer(this IServiceCollection services)
        {
            // DI Services for Repositories and UnitOfWork
            services.AddScoped<IServiceCategory, ServiceCategory>();
            services.AddScoped<IServiceProduct, ServiceProduct>();
        }
    }
}

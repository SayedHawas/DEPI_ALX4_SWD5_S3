
namespace ASPCoreWebAPINewDemos
{
    public class Program
    {
        // The main entry point of the application.
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddControllers();
            //builder.Services.AddControllers().AddJsonOptions(option =>
            //{
            //    option.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
            //});

            //Connection with Database Context
            builder.Services.AddDbContext<AppDbContext>(option =>
            {
                option.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection"));
            });
            //Registering the UnitOfWork service with the dependency injection container.
            //This allows the application to use the UnitOfWork pattern for managing database transactions and operations.

            builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();
            builder.Services.AddScoped(typeof(IRepository<>), typeof(Repository<>));

            // DI Services for Repositories and UnitOfWork
            builder.Services.AddScoped<IServiceCategory, ServiceCategory>();
            builder.Services.AddScoped<IServiceProduct, ServiceProduct>();

            //using extension method to add services for AddServicesForServiceLayer
            //builder.Services.AddServicesForServiceLayer();


            // Learn more about configuring OpenAPI at https://aka.ms/aspnet/openapi
            builder.Services.AddOpenApi();
            //Add Services to the container for Dependency Injection
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            // The following code checks if the application is running in a development environment. If it is, it maps the OpenAPI documentation to the application. This allows developers to easily access and test the API endpoints during development.
            if (app.Environment.IsDevelopment())
            {
                app.MapOpenApi();
                //Adding Swagger UI middleware to the application. This will enable the Swagger UI interface, which provides a user-friendly way to interact with the API documentation and test the API endpoints.
                app.UseSwaggerUI();
                app.UseSwagger();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}

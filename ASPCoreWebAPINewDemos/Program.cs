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

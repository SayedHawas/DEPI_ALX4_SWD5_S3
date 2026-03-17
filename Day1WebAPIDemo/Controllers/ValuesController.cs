using Day1WebAPIDemo.Models;
using Microsoft.AspNetCore.Mvc;

namespace Day1WebAPIDemo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        static List<Employee> employees = new List<Employee>()
        {
            new Employee(){Id=1, Name="Ahmed", Department="IT", Email="" },
            new Employee(){Id=2, Name="Ali", Department="HR", Email="" },
        };
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(employees.ToList());
        }
    }
}

using Microsoft.AspNetCore.Mvc;

namespace Day1WebAPIDemo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    //https://localhost:7280/api/demo
    public class DemoController : ControllerBase
    {
        // CRUD - Create, Read, Update, Delete
        //Data Source                                      0         1    2           3
        static List<string> names = new List<string>() { "Ahmed", "Ali", "Retaj", "Mariem " };
        //Read all
        //https://localhost:7280/api/demo
        [HttpGet]
        public IActionResult Get()
        {
            return Ok(names);
        }
        //Read by id
        //https://localhost:7280/api/demo/1
        [HttpGet("{id:int}")]
        public string GetByID(int id)
        {
            if (id > names.Count || id < 1)
                return "Not Found ...";
            return names[id - 1];
        }
        //https://localhost:7280/api/demo/ahmed
        [HttpGet("{name:alpha}")]
        public string GetByName(string name)
        {
            if (names.Contains(name))
                return name;
            return "Not Found ...";
        }
        //Create
        [HttpPost]
        public string Create(string newName)
        {
            names.Add(newName);
            return "add Name ...";
        }
        [HttpPut]
        public string Update(int id, string NewName)
        {
            if (id > names.Count || id < 1)
                return "Not Found ...";
            else
            {
                names[id - 1] = NewName;
                return "Update Name ";
            }
        }
        [HttpDelete]
        public string Delete(int id)
        {
            if (id > names.Count || id < 1)
                return "Not Found ...";
            else
            {
                names.RemoveAt(id - 1);
                return "Delete Name ...";
            }
        }

    }
}

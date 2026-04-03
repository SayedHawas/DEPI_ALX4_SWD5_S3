using Microsoft.AspNetCore.Mvc;

namespace ASPCoreWebAPINewDemos.Controllers
{
    //https://localhost:7015/api/demos
    [Route("api/[controller]")]
    [ApiController]
    public class DemosController : ControllerBase
    {
        //https://localhost:7015/api/demos
        [HttpGet]
        public string get()
        {
            return "Hello World";
        }

        //[Route("{id}")]
        //[HttpGet]
        [HttpGet("{id:int}")]
        //https://localhost:7015/api/demos/100   Value Route  URL string 
        public string get(int id)
        {
            return $"Hello World {id}";
        }

        //[HttpGet("getName")]
        //[FromQuery]
        //https://localhost:7015/api/demos/getname?name=ahmed  Query string
        //
        //https://localhost:7015/api/demos/ahmed
        [HttpGet("{name:alpha}")]
        public string get(string name)
        {
            return $"Hello World {name}";
        }
        [HttpPost]
        public string Post(string name)
        {
            return "Hello World From Post Method";
        }

    }
}

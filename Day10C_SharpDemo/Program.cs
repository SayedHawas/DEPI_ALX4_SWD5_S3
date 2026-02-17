using System.Text.Json;

namespace Day10C_SharpDemo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            #region session 10 Part 1 

            Person person = new Person { Name = "John Doe", Age = 30 };


            //// Serialize the object to a file
            //using (FileStream fs = new FileStream("person.exe", FileMode.Create))
            //{
            //    BinaryFormatter formatter = new BinaryFormatter();
            //    formatter.Serialize(fs, person);
            //}

            //// Deserialize the object from the file
            //using (FileStream fs = new FileStream("person.dat", FileMode.Open))
            //{
            //    BinaryFormatter formatter = new BinaryFormatter();
            //    Person deserializedPerson = (Person)formatter.Deserialize(fs);
            //    Console.WriteLine($"Name: {deserializedPerson.Name}, Age: {deserializedPerson.Age}");
            //}

            // Stream: FileStream
            // Serialize the object to a file
            //using (FileStream fs = new FileStream("person.xml", FileMode.Create))
            //{
            //    XmlSerializer serializer = new XmlSerializer(typeof(Person));
            //    serializer.Serialize(fs, person);
            //}

            //// De-serialize the object from the file
            //using (FileStream fs = new FileStream("person.xml", FileMode.Open))
            //{
            //    XmlSerializer serializer = new XmlSerializer(typeof(Person));
            //    Person deserializedPerson = (Person)serializer.Deserialize(fs);
            //    Console.WriteLine($"Name: {deserializedPerson.Name}, Age: {deserializedPerson.Age}");
            //}
            using (FileStream fs = new FileStream("person.xml", FileMode.Create))
            {

            }
            //try
            //{

            //}
            //finally
            //{

            //}

            using (Person p = new Person())
            {
                p.Name = "sayed";
            }

            //p


            // Serialize the object to a JSON string
            string jsonString = JsonSerializer.Serialize(person);
            File.WriteAllText("person.json", jsonString);

            // Deserialize the object from the JSON string
            string jsonStringFromFile = File.ReadAllText("person.json");
            Person deserializedPerson = JsonSerializer.Deserialize<Person>(jsonStringFromFile);
            Console.WriteLine($"Name: {deserializedPerson.Name}, Age: {deserializedPerson.Age}");

            #endregion
            Console.ReadLine();
        }
    }
    [Serializable]
    public class Person : IDisposable
    {
        public string Name { get; set; }
        public int Age { get; set; }

        public void Dispose()
        {
            this.Dispose();
        }

        public Person()
        {

        }

        ~Person()
        {

        }
    }
}

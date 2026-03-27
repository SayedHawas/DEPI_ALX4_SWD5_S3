using AspCoreWebAPICodeFirst.Models;
using Microsoft.EntityFrameworkCore;
namespace AspCoreWebAPICodeFirst
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");

            //CRUD Operations
            using (var db = new AppDbContext())
            {

                //Read All Records Without Any Change AsNoTracking 
                Console.WriteLine(" -------------------- Read ALL -----------------------");
                var students = db.Students.AsNoTracking().ToList();
                foreach (var student in students)
                {
                    Console.WriteLine($"Id: {student.Id}, Name: {student.Name}, Age: {student.Age} , Email {student.Email}");
                }
                Console.WriteLine(" -------------------- Read One -----------------------");
                //Read Single Record By Id
                //var selectStudent = db.Students.Find(1); // As No Tracking
                var selectStudent = db.Students.AsNoTracking().FirstOrDefault(e => e.Id == 1);
                Console.WriteLine($"Id: {selectStudent.Id}, Name: {selectStudent.Name}, Age: {selectStudent.Age} , Email {selectStudent.Email}");

                Console.WriteLine(" -------------------- Create  -----------------------");
                //Create New Record
                var newStudent = new Student
                {
                    Name = "Ahmed Ali",
                    Age = 25,
                    Email = "AhmedAli@gmail.com"
                };
                //Add in Memory
                db.Students.Add(newStudent);
                Console.WriteLine(db.Entry<Student>(newStudent).State);

                Console.WriteLine(" -------------------- Update  -----------------------");
                //Update
                var updateStudent = db.Students.FirstOrDefault(e => e.Id == 2);
                //To Change 
                updateStudent.Name = "Mariem ElSayed";
                Console.WriteLine(db.Entry<Student>(updateStudent).State);

                Console.WriteLine(" -------------------- Delete  -----------------------");
                var deleteStudent = db.Students.FirstOrDefault(e => e.Id == 3);
                //To Remove
                db.Remove(deleteStudent);
                Console.WriteLine(db.Entry<Student>(deleteStudent).State);

                Console.WriteLine(" -------------------- Change Tracker  -----------------------");
                //Tracking Changes
                Console.WriteLine(db.ChangeTracker.ToDebugString());

                db.SaveChanges();
                Console.ReadLine();

            }
        }
    }
}

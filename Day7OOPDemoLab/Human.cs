namespace Day7OOPDemoLab
{
    public abstract class Human
    {
        private int _id;
        private string _name;
        protected Human()
        {

        }

        public int Id { get => _id; set => _id = value; }
        public string Name { get => _name; set => _name = value; }

        public abstract string SayHello();
    }
}

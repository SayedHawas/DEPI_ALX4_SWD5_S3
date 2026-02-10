namespace Day7OOPDemoLab
{
    public interface IOperation
    {
        //private int _id;

        //.Net 9 ,10
        //public void Save()
        //{
        //}

        void Save(Employee Entity);
        void Update(int id, Employee NewEntity);
        void Delete(int id);
    }
}

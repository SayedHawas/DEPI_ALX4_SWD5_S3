namespace Day7OOPDLL
{
    public class MyHelper
    {
        private string version;
        public void Save()
        {
            //Code ...
            Console.WriteLine("Saving ...");
        }

        private int PrivateValue { get; set; }                      // X         X
        public int PublicValue { get; set; }                        // O         O
        internal int InternalValue { get; set; }                    // O         O
        protected int ProtectedValue { get; set; }                  // X         O
        internal protected int InternalProtectedValue { get; set; } // O  X      O  O
        private protected int PrivateProtectedValue { get; set; }   // X  X      X  O
    }
}

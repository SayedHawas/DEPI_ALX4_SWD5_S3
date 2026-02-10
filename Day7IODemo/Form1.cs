namespace Day7IODemo
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //DriveInfo di = new DriveInfo("C");
            DriveInfo[] drives = DriveInfo.GetDrives();
            foreach (DriveInfo drive in drives)
            {
                if (drive.DriveType == DriveType.Fixed)
                    comboBox1.Items.Add(drive.Name);
            }

            //comboBox1.DataSource = drives;

        }

        private void button1_Click(object sender, EventArgs e)
        {
            DriveInfo di = new DriveInfo(comboBox1.Text);
            MessageBox.Show(di.Name + " " + di.DriveType + " " + (di.AvailableFreeSpace / 1024 / 1024 / 1024) + "GB " + "Format : " + di.DriveFormat);
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string[] Folder = Directory.GetDirectories(comboBox1.Text);
            listBox1.DataSource = Folder;

            //DirectoryInfo drive = new DirectoryInfo(comboBox1.Text);
            //DirectoryInfo[] folders  = drive.GetDirectories();
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string[] files = Directory.GetFiles(listBox1.Text);
            listBox2.DataSource = files;
        }

        private void listBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            pictureBox1.ImageLocation = listBox2.Text;
        }
    }
}

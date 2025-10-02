public class Program
{
    public int Add(int a, int b)
    {
        return a + b;
    }

    public int Multiply(int a, int b)
    {
        return a * b;
    }

    static void Main(string[] args)
    {
        Program prg = new Program();
        int number = prg.Add(1, 3);

        Console.WriteLine(number);
    }
}
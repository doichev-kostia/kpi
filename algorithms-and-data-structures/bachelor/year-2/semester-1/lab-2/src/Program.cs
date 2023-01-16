namespace Lab2;

class Program
{
    public static void Main(string[] args)
    {
        try
        {
            State startState = new State();
            Console.WriteLine("Start state:");
            Console.WriteLine(startState);
            foreach (var col in startState.field)
            {
                Console.Write($"{col} ");
            }
            Console.WriteLine();
            Node root = new Node(startState);
            SearchAlgorithm algorithm;
            Console.WriteLine("Choose LDFS or A*? [0/1]: ");
            int algoChoice = Int32.Parse(Console.ReadLine());
            if (algoChoice == 0)
            {
                Console.Write("Enter the limit for search: ");
                int limit = Int32.Parse(Console.ReadLine());
                algorithm = new LDFSAlgo(root, limit);
            }
            else
            {
                algorithm = new AStarAlgo(root);
            }
            
            Console.WriteLine(algorithm.DisplayResults());
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
        }
    }
}


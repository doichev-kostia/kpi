namespace Lab2;

public class Node
{
    private Node? parent;

    public State State { get; }
    public int Depth { get; }
    public Node[] Successors { get; set; }
    
    internal int Cost() => Depth + State.F2();
    
    public Node(State InitialState)
    {
        parent = null;
        State = InitialState;
        Depth = 0;
    }
    
    public Node(Node parentNode, int queenColumn, byte position)
    {
        parent = parentNode;
        Depth = parentNode.Depth + 1;
        State = new State(parentNode.State, queenColumn, position);
    }

    public override string ToString()
    {
        return State.ToString();
    }

    public static void Expand(Node node)
    {
        int index = 0;
        node.Successors = new Node[node.State.field.Length * (node.State.field.Length - 1)];
        for (int i = 0; i < node.State.field.Length; i++)
        {
            for (byte j = 0; j < node.State.field.Length; j++)
            {
                if(node.State.field[i] == j) 
                    continue;
                node.Successors[index++] = new Node(node, i, j);
            }
        }
    }
}
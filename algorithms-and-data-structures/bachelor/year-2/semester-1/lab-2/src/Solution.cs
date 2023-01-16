namespace Lab2;

public class Solution
{
    public Node? node { get; }
    public Status status { get; }

    public Solution(Node? node, Status status)
    {
        this.node = node;
        this.status = status;
    }
}
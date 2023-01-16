namespace Lab2;

public class AStarAlgo : SearchAlgorithm
{
    
    public AStarAlgo(Node problem)
    {
        _statistics = new AlgoStatistics();
        _statistics.Stopwatch.Start();

        _statistics.Solution = Search(problem);
        _statistics.Stopwatch.Stop();

    }

    public override Solution Search(Node problem)
    {
        if (_statistics.Stopwatch.ElapsedMilliseconds >= AlgoStatistics.TimeLimit)
        {
            return new Solution(null, Status.TIME_EXCEED);
        }

        PriorityQueue<Node, int> open = new PriorityQueue<Node, int>();
        HashSet<State> closed = new HashSet<State>();
        open.Enqueue(problem, problem.State.F2());
        while (open.Count != 0)
        {
            ++_statistics.Iterations;
            Node current = open.Dequeue();
            if (current.State.F2() == 0)
            {
                _statistics.TotalStates = _statistics.StatesInMemory = open.Count + closed.Count;
                return new Solution(current, Status.SUCCESS);
            }
            closed.Add(current.State);
            Node.Expand(current);
            foreach (var successor in current.Successors)
            {
                if(!closed.Contains(successor.State))
                    open.Enqueue(successor, successor.State.F2());
            }
        }

        return new Solution(null, Status.FAILURE);
    }
    
}
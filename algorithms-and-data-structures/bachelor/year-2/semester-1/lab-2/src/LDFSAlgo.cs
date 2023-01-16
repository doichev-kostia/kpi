namespace Lab2;

public class LDFSAlgo : SearchAlgorithm
{
    private HashSet<State> TotalStates;
    private HashSet<State> StatesInMemory;
    private readonly int _limit;
    public LDFSAlgo(Node node, int lim)
    {
        _limit = lim;
        TotalStates = new HashSet<State>();
        StatesInMemory = new HashSet<State>();
        _statistics.Stopwatch.Start();
        _statistics.Solution = Search(node);
        _statistics.Stopwatch.Stop();
        _statistics.StatesInMemory = StatesInMemory.Count;
        _statistics.TotalStates = TotalStates.Count;
    }


    public override Solution Search(Node node)
    {
        return RecursiveDLS(node);
    }
    
    private Solution RecursiveDLS(Node node)
    {
        ++_statistics.Iterations;
        if (_statistics.Stopwatch.ElapsedMilliseconds >= AlgoStatistics.TimeLimit)
        {
            ++_statistics.DeadEnds;
            return new Solution(null, Status.TIME_EXCEED);
        }
        
        bool cutoffOccured = false;
        if (node.State.F2() == 0)
            return new Solution(node, Status.SUCCESS);
        if (node.Depth == _limit)
        {
            ++_statistics.DeadEnds;
            return new Solution(null, Status.CUTOFF);
        }
        TotalStates.Add(node.State);
        Node.Expand(node);
        foreach (var successor in node.Successors)
        {
            TotalStates.Add(successor.State);
            Solution result = RecursiveDLS(successor);
            
            if (result.status == Status.TIME_EXCEED)
                return result;
            
            if (result.status == Status.CUTOFF)
                cutoffOccured = true;

            else if (result.status != Status.FAILURE)
            {
                foreach (var succ in node.Successors)
                    StatesInMemory.Add(succ.State);
                
                return result;
            }
        }

        if (cutoffOccured)
            return new Solution(null, Status.CUTOFF);

        return new Solution(null, Status.FAILURE);
    }
}
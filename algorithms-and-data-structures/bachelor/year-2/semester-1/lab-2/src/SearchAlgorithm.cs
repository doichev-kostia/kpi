namespace Lab2;

public abstract class SearchAlgorithm
{
    internal AlgoStatistics _statistics;

    public SearchAlgorithm()
    {
        _statistics = new AlgoStatistics();
    }

    public abstract Solution Search(Node problem);
    
    public string DisplayResults()
    {
        return _statistics.Results() + _statistics.Stats();
    }
}
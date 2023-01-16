using System.Diagnostics;

namespace Lab2;

public class AlgoStatistics
{
    public Solution Solution { get; set; }
    public long Iterations { get; set; }
    public int DeadEnds { get; set; }
    public Stopwatch Stopwatch { get; }
    public long TotalStates { get; set; }
    public long StatesInMemory { get; set; }

    public static int TimeLimit = 1800000;

    public AlgoStatistics()
    {
        Iterations = 0;
        DeadEnds = 0;
        TotalStates = 0;
        StatesInMemory = 0;
        Stopwatch = new Stopwatch();
    }
    public string Results() => Solution.status switch
        {
            Status.SUCCESS => "Solution found successfully!\n" + Solution.node.State,
            Status.CUTOFF => "The search was cut off.\n",
            Status.FAILURE => "The search has failed.\n",
            Status.TIME_EXCEED => "The search has exceeded the time limit.",
        };

    public string Stats() => $"Iterations: {Iterations}\nTime elapsed: {Stopwatch.ElapsedMilliseconds} ms\nDead ends: {DeadEnds}\nTotal states: {TotalStates}\nStates in memory: {StatesInMemory}" ;
}
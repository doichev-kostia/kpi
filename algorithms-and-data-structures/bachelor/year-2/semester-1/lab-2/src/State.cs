namespace Lab2;

public class State
{
    public byte[] field { get; set; }
    public static int Size = 8;
    public State()
    {
        field = new byte[Size];
        Random random = new Random();
        for (int i = 0; i < Size; i++)
            field[i] = (byte)random.Next(0, Size);
    }

    public State(State other, int column, byte newPosition)
    {
        field = new byte[other.field.Length];
        Array.Copy(other.field, field, other.field.Length);
        field[column] = newPosition;
    }

    public override string ToString()
    {
        string output = "";
        for (int i = 0; i < field.Length; i++)
        {
            for (int j = 0; j < field.Length; j++)
            {
                if (i == field[j])
                    output += "[Q]";
                else
                    output += "[ ]";
            }

            output += "\n";
        }

        return output;
    }

    public int F2()
    {
        int conflicts = 0;
        for (int i = 0; i < field.Length; i++)
        {
            for (int j = i + 1; j < field.Length; j++)
            {
                if (field[i] == field[j])
                    conflicts++;

                if (i - field[i] == j - field[j])
                    conflicts++;

                if (i + field[i] == j + field[j])
                    conflicts++;
            }
        }

        return conflicts;
    }
}
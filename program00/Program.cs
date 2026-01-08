using average;

namespace Program;

public class Program00{
    public static int Main(){
        AverageCalculator calc = new AverageCalculator();
        calc.add(34);
        System.Console.WriteLine(calc.ToString());
        return 0;
    }
}
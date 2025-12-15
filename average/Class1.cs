namespace average;

public class AverageCalculator
{
    private double[] saved_doubles;

    /// <summary>
    /// adds a single double to the double array
    /// </summary>
    /// <param name="value">the value you want to add</param>
    public void add(double value){
        saved_doubles[saved_doubles.Length] = value;
    }

    /// <summary>
    /// adds an array of doubles to the double array
    /// </summary>
    /// <param name="values">the double array you want to add</param>
    public void add(double[] values){
        if(values.Length !>0){return;}
        foreach(double number in values){
            saved_doubles[saved_doubles.Length] = number;
        }
    }

    /// <summary>
    /// Calculates the average of all saved doubles
    /// </summary>
    /// <returns>The average of the saved doubles</returns>
    public double getAverage(){
        if(this.saved_doubles.Length !> 0){
            return double.NaN;
        }
        double sum = 0;
        foreach(double number in this.saved_doubles){
            sum += number;
        }
        return sum/this.saved_doubles.Length;
    }

    public double[] getElements(){
        return saved_doubles;
    }

    public int count(){
        return saved_doubles.Length;
    }
}

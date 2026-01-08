using average;
namespace Tests;

public class Test1
{
    [Fact]
    public void Test_single_element()
    {
        AverageCalculator calc = new AverageCalculator();
        calc.add(54);
        double[] expected = {54};
        for (int i = 0; i < expected.Length; i++)
        {
            Assert.Equal(expected[i], calc.getElements()[i], precision: 4);
        }
    }
    [Fact]
    public void Test_normal_add_classic()
    {
        AverageCalculator calc = new AverageCalculator();
        calc.add(34);
        calc.add(2);
        double[] expected = {34, 2};
        for (int i = 0; i < expected.Length; i++)
        {
            Assert.Equal(expected[i], calc.getElements()[i], precision: 4);
        }
    }

    [Fact]
    public void test_empty_array(){
        AverageCalculator calc = new AverageCalculator();
           double[] expected = {};
        for (int i = 0; i < expected.Length; i++)
        {
            Assert.Equal(expected[i], calc.getElements()[i], precision: 4);
        }
    }
}
@isTest
public class AulaTeste {

    @isTest
    public static void myUnitTest() {

        Test.startTest();
        Decimal temp = TemperatureConverter.FahrenheitToCelsius(70.45);
        Test.stopTest();
        
        System.debug(temp);

        Assert.areEqual(21.36, temp, 'String opcional caso o teste falhe - ' + temp);
    }    
}
@isTest
private class AulaTeste {

    // Para acessar os dados da organização, anote o método de teste com @isTest(SeeAllData=true)
    
    @isTest
    static void myUnitTest() {

        Test.startTest();
        Decimal temp = TemperatureConverter.FahrenheitToCelsius(70.45);
        Test.stopTest();

        Assert.areEqual(20, temp, 'String opcional caso o teste falhe');
    }    
}
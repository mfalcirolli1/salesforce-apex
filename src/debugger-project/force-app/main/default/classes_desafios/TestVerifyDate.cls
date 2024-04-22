@isTest
public class TestVerifyDate {

    @isTest
    public static void CheckDates_Test_1() {
        
        Test.startTest();
        Date dt = VerifyDate.CheckDates(Date.today(), Date.today().addDays(-30));
        Test.stopTest();
        Assert.IsNotNull(dt);
    }

    @isTest
    public static void CheckDates_Test_2() {
        
        Test.startTest();
        Date dt = VerifyDate.CheckDates(Date.today(), Date.today().addDays(10));
        Test.stopTest();
        Assert.IsNotNull(dt);
    }

    @isTest
    public static void DateWithin30Days_Test_1() {
        
        Test.startTest();
        Boolean thrityDays = VerifyDate.DateWithin30Days(Date.today(), Date.today().addDays(-30));
        Test.stopTest();
        Assert.isFalse(thrityDays);
    }

    @isTest
    public static void DateWithin30Days_Test_2() {
        
        Test.startTest();
        Boolean thrityDays = VerifyDate.DateWithin30Days(Date.today().addDays(-30), Date.today());
        Test.stopTest();
        Assert.isFalse(thrityDays);
    }

    @isTest
    public static void DateWithin30Days_Test_3() {
        
        Test.startTest();
        Boolean thrityDays = VerifyDate.DateWithin30Days(Date.today(), Date.today().addDays(10));
        Test.stopTest();
        Assert.isFalse(thrityDays);
    }

    @isTest
    public static void SetEndOfMonthDate_Test() {
        
        Test.startTest();
        Date dt = VerifyDate.SetEndOfMonthDate(Date.today());
        Test.stopTest();
        Assert.IsNotNull(dt);
    }
}
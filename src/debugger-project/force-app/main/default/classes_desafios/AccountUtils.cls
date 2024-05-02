public with sharing class AccountUtils {
    
    public static List<Account> accountsByState(String billingState) {

        List<Account> accounts = [SELECT Id, Name FROM Account WHERE BillingState = :billingState];
        return accounts;
    }
}
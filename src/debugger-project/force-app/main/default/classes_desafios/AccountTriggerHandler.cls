public with sharing class AccountTriggerHandler {
    
    public static void CreateAccounts(List<Account> contas) {

        for(Account conta : contas){

            conta.ShippingState = conta.BillingState;
        }
    }
}
public with sharing class AccountTriggerHandler {
    
    public static void CreateAccounts(List<Account> contas) {

        for(Account conta : contas){

            conta.ShippingState = conta.BillingState;
        }
    }

    @AuraEnabled(cacheable=true)
    public static string ObterPrimeiraConta(String billingState) {

        List<Account> accts = [ SELECT Id, Name, AccountNumber, TickerSymbol FROM Account WHERE BillingState = :billingState ];
        return accts[0].Name;
    }
}
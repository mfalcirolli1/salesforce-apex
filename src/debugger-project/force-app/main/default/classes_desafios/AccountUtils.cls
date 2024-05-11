public with sharing class AccountUtils {
    
    public static void CriarContasExemplo(String billingState) {

        List<Account> accts = [ SELECT Id, Name, AccountNumber, TickerSymbol FROM Account WHERE BillingState = :billingState ];
        List<Account> newAccts = new List<Account>();

        if(accts.size() == 0){
            System.debug('Não foram encontradas contas nessa Org. Bora criar algumas...');

            for(Integer i = 1; i <= 3; i++){

                Account ac = new Account(
                    Name = 'Conta teste ' + i,
                    BillingState = billingState
                );
                System.debug('Nome da conta criada: ' + ac.Name);
                newAccts.add(ac);
            }

            insert newAccts;
        }
        else{           
            System.debug('Encontrei algumas contas nessa Org.');

            for(Account account : accts){
                System.debug('Nome da conta: ' + account.Name);
            }
        }
    }
}
@isTest
public class AccountTriggerTest {
    
    @isTest
    static void Inserir_200_Registros_AccountTrigger_Test() {

        // Arrange
        List<Account> novasContas = new List<Account>();
        Boolean temAcessoCriacao = Schema.SObjectType.Account.isCreateable();

        if(temAcessoCriacao){

            for(Integer i = 1; i <= 200; i++){
    
                Account conta = new Account(
                    Name = 'Conta Desafio - Noções básicas de Apex e .NET ' + i,
                    BillingState = 'CA' 
                );
    
                novasContas.add(conta);
            }
            
            // Act
            Test.startTest();
            if(novasContas.size() > 0){

                insert novasContas;
            }
            Test.stopTest();
        }
        else{
            System.debug('Usuário não possui acesso para criar contas (Account)');
        }

        // Assert
        List<Account> contasInseridas = [SELECT ShippingState FROM Account WHERE Name like '%Conta Desafio%'];
        for(Account conta : contasInseridas){

            System.assertEquals('CA', conta.ShippingState);
        }
    }
}
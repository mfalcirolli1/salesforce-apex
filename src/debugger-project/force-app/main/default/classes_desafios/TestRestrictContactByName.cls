@isTest
private class TestRestrictContactByName {

    @isTest
    static void InsertNewAccountWithInvalidLastName() {

        Test.startTest();

            Contact cont = new Contact(FirstName = 'Matheus',
            LastName = 'INVALIDNAME',
            Email = 'Teste@email.com');

            insert cont;

        Test.stopTest();
    }

    @isTest
    static void UpdateNewAccountWithInvalidLastName() {

        Test.startTest();

            List<Contact> cont = [SELECT Id, FirstName, LastName, Email From Contact WHERE LastName = 'INVALIDNAME'];
            System.debug('TOTAL DE CONTATOS ENCONTRADOS: ' + cont);

            for(Contact c : cont){
                
                c.Title = 'Invalid';
                update cont;
            }

        Test.stopTest();
    }
}
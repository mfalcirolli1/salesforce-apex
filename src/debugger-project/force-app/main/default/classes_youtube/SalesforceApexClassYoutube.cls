public with sharing class SalesforceApexClassYoutube {
    
    // with sharing
    // without sharing
    // inherited sharing 

    public String type;
    private Integer name;

    public static void Episode_9_PrimitiveDataTypes() {

        ID meuId = '003XXXXXXXXXXXX';
        Boolean bol = true;
        Integer num = 2;
        Long numm = 3000000L;
        String name = 'Mat';
        Double doub = 23.96;
        Decimal dec = 10.574343; // Alta precisão
        Date date1 = Date.today();
        Date date2 = Date.newInstance(2024, 4, 25);
        Datetime dt = Datetime.now();
        Blob blb = Blob.valueOf('Conteúdo binário');

        System.debug(name.capitalize());
    }

    public static void Episode_15_Operators(){

        // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_expressions_operators_understanding.htm

        Integer x = 10;
        Integer y = 100;

        // Assignment -> x = y
        // Addition assignemnt -> x += y
        System.debug('Addition assignemnt: ' + (x += y));
        // Multiplication assignment -> x *= y
        System.debug('Multiplication assignemnt: ' + (x *= y));
        // Subtraction assignment -> x -= y
        System.debug('Subtraction assignemnt: ' + (x -= y));
        // Division assignment -> x /= y
        System.debug('Division assignemnt: ' + (x /= y));
        // AND logical operator -> x && y
        // OR logical operato -> x || y
        // Equality operator -> x == y
        // Less than operator -> x < y | x <= y
        // Greater than operator -> x > y | x >= y
        // Increment operator -> x++ Incrementa na próxima linha | ++x Incrementa antes
        System.debug(x);
        System.debug('Increment operator x++: ' + (x++)); 
        System.debug(x);
        System.debug('Increment operator ++x: ' + (++x));
    }

    public static void Episode_10_NonPrimitiveDataTypes() {

        // SObjects, Enums, Null, Classes, Interfaces, Collections (List, Map, Set)

        Contact cont = new Contact();
        cont.FirstName = 'Primeiro nome';
        cont.LastName = 'Último nome';
        System.debug('* Contato: ' + cont);

        List<Integer> minhaLista = new List<Integer>(); // Coleção ordenada. Elementos acessados por índice. 
        minhaLista.add(10);
        minhaLista.add(20);
        minhaLista.add(10);
        minhaLista.remove(2);
        minhaLista.clear();
        minhaLista.clone();
        System.debug('* Elementos List: ' + minhaLista);

        Set<String> meuSet = new Set<String>(); // Coleção não ordenada. Elementos não podem ser acessados por índice. Elementos duplicados são removidos.
        meuSet.add('maçã');
        meuSet.add('laranja');
        meuSet.add('maçã');
        System.debug('* Elementos Set: ' + meuSet);

        Map<String, Integer> meuMap = new Map<String, Integer>(); // Coleção de pares chave-valor, onde cada chave é única.
        meuMap.put('um', 1);
        meuMap.put('dois', 2);
        System.debug('* Elementos Map: ' + meuMap);
    }

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

    public static void DeletarContasExemplo(String billingState) {

        Schema.DescribeSObjectResult describeAccountAccess = Account.SObjectType.getDescribe();
        System.debug('Account IsDeletable: ' + describeAccountAccess.isDeletable());

        Boolean deletable = Schema.SObjectType.Account.isDeletable();
        System.debug('Object "Account" isDeletable: ' + deletable);

        //  By checking access to the field, you’re also implicitly checking that the user has created access on the object

        Boolean updateable = Schema.SObjectType.Account.fields.Name.isUpdateable();
        System.debug('Field "Account.Name" isUpdateable: ' + updateable);

        Boolean createable = Schema.SObjectType.Account.fields.AccountNumber.isCreateable();
        System.debug('Field "Account.AccountNumber" isCreateable: ' + createable);

        Boolean accessible = Schema.SObjectType.Account.fields.TickerSymbol.isAccessible();
        System.debug('Field "Account.TickerSymbol" isAccessible: ' + accessible);

        if(deletable){

            List<Account> accts = [ SELECT Id, Name, AccountNumber, TickerSymbol FROM Account WHERE BillingState = :billingState ];
    
            if(accts.size() > 0){
                System.debug('Contas encontradas para deletar: ' + accts.size());
                delete accts;
            }
            else{           
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Insufficient Access'));
                System.debug('Não encontrei contas para deletar.');
            }
        }
        else{
            System.debug('Usuário não possui acesso para deletar contas.');
        }

    }

    public static void sendMail(String address, String subject, String body) {

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};

        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);

        Messaging.SendEmailResult[] results = Messaging.sendEmail(
            new Messaging.SingleEmailMessage[] { mail });

        if(results[0].isSuccess()){

            System.debug('Email enviado com sucesso');
        }else{
            for(Messaging.SendEmailError erros : results[0].getErrors()){
                System.debug(erros);
            }
        }
    }
    
    public static void Search_SOSL(){
        
        // FIND {Cloud Kicks} RETURNING Account
        // FIND {Cloud Kicks} RETURNING Account (Name, Industry)
        // FIND {Cloud Kicks} RETURNING Account (Name, Industry ORDER BY Name)
        // FIND {Cloud Kicks} RETURNING Account (Name, Industry ORDER BY Name LIMIT 10)
        // FIND {Cloud Kicks} RETURNING Account (Name, Industry ORDER BY Name LIMIT 10 OFFSET 25)
        // FIND {Cloud Kicks} RETURNING Account (Name, Industry) WITH DIVISION = 'Global'
    }

    // SOQL -> Para pesquisas de um único objeto quando conhece os campos a serem pesquisados (você sabe em qual campo os dados residem)
    // SOSL -> Para pesquisas de um ou vários objetos quando não conhece os campos a serem pesquisados.

    // SOSL
    
    // Pesquisar em um único objeto
    // FIND {term} RETURNING ObjectTypeName -> FIND {march 2016 email} RETURNING Campaign

    // Pesquisar em vários objetos
    // FIND {term} RETURNING ObjectTypeName1, ObjectTypeName2, ObjectTypeNameYouGetTheIdea -> FIND {recycled materials} RETURNING Product2, ContentVersion, FeedItem

    // Pesquisar em objetos personalizados
    // FIND {pink hi\-top} RETURNING Merchandise__c (acrescentar o sufixo '__c')
}
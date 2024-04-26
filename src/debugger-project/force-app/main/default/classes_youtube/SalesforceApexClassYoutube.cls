public with sharing class SalesforceApexClassYoutube {
    
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

        List<Account> accts = [ SELECT Id, Name, AccountNumber, TickerSymbol FROM Account WHERE BillingState = :billingState ];

        if(accts.size() > 0){
            System.debug('Contas encontradas para deletar: ' + accts.size());
            delete accts;
        }
        else{           
            System.debug('Não encontrei contas para deletar.');
        }
    }
}
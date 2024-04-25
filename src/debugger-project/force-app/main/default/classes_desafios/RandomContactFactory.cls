public with sharing class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numeroContatosExclusivos, String sobrenomeComum) {

        List<Contact> lista = new List<Contact>();

        for(Integer i = 1; i <= numeroContatosExclusivos; i++){

            Contact cont = new Contact(
            FirstName = 'Teste ' + i,
            LastName = sobrenomeComum
            );

            lista.add(cont);

            System.debug(cont.FirstName + ' ' + cont.LastName);
        }

        return lista;
    }
}
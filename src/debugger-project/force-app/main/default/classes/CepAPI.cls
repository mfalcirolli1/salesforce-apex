public with sharing class CepAPI {

    @AuraEnabled
    public static ViaCepModel ReturnAddressByCep(string cep) {

        try {
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
    
            request.setMethod('GET');
            request.setEndpoint('https://viacep.com.br/ws/' + cep + '/json/');
            //request.setHeader('Authorization', 'Bearer seu_token_de_autenticacao');
    
            HttpResponse response = http.send(request);
    
            if (response.getStatusCode() != 200) {
                System.debug('Erro: ' + response.getStatus() + ' - ' + response.getStatusCode());         
            }

            String responseBody = response.getBody();
            System.debug(responseBody);
            ViaCepModel obj = (ViaCepModel) JsonConvert.fromJson(responseBody, ViaCepModel.class);
            System.debug(obj);
            System.debug(obj.cep);
            return obj;
        } 
        catch (Exception ex) {
            System.debug('Exception: ' + ex.getMessage() + '\n' + ex.getStackTraceString());
            throw ex;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> ReturnAllContacts(){

        try {
            List<Contact> contacts = [SELECT Id, Name, MailingAddress FROM Contact ORDER BY Name DESC];
            System.debug(contacts);
            return contacts;
            
        } catch (Exception ex) {
            System.debug('Exception: ' + ex.getMessage() + '\n' + ex.getStackTraceString());
            throw ex;
        }
    }
}

// Setup > Security > Remote Site Settings > New Remote Site

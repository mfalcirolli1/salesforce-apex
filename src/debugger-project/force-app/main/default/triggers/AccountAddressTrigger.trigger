trigger AccountAddressTrigger on Account (before insert, before update) {

    if(Trigger.isInsert || Trigger.isUpdate){
        if(Trigger.isBefore){
            for(Account act : Trigger.new){
                if(act.Match_Billing_Address__c){
                    act.ShippingPostalCode = act.BillingPostalCode;
                }
            }
        }
    }
}


/*
    trigger TriggerName on ObjectName (trigger_events) {
    code_block
    } 
--
    before insert (antes de inserir)
    after insert (após inserir)

    before update (antes de atualizar)
    after update (após atualizar)

    before delete (antes de excluir)
    after delete (após excluir)

    after undelete (após desfazer exclusão)

    ** Se executar instruções DML (insert, update, delete) nesses registros, receberá um erro **
--
    Trigger.new --> Contém todos os registros que foram inseridos nos acionadores de inserção ou atualização
    Trigger.old --> Fornece a versão antiga de sObjects antes de eles serem atualizados nos acionadores de atualização, ou uma lista de sObjects excluídos nos acionadores de exclusão
--
    Outras variáveis ​​de contexto exibem um valor booleano para indicar se o acionador foi disparado devido a uma atualização ou a algum outro evento

    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            // Process before insert
        } else if (Trigger.isAfter) {
            // Process after insert
        }        
    }
    else if (Trigger.isDelete) {
        // Process after delete
    }

    -> isExecuting | isInsert | isUpdate | isDelete | isBefore | isAfter | isUndelete | new | newMap | old | oldMap | operationType | size | Trigger.new.size()
--
    addError(): Lança um erro fatal dentro de um acionador. A mensagem de erro é exibida na interface de usuário e é registrada

    for(Contact c : Trigger.New) {

      if(c.LastName == 'INVALIDNAME') {
        c.AddError('The Last Name "'+c.LastName+'" is not allowed for DML');
      }
    }
--
    Callouts: Chamadas Apex a serviços web externos são referidas como callouts.
    Ao fazer um callout a partir de um acionador, o callout deve ser feito de forma assíncrona para que o processo do acionador não o impeça de trabalhar enquanto aguarda pela resposta do serviço externo.
    Em um trigger, chame um método de classe que execute de forma assíncrona (@future(callout=true))

    public class CalloutClass {

        @future(callout=true)
        public static void makeCallout() {
            HttpRequest request = new HttpRequest();
            String endpoint = 'http://yourHost/yourService';
            request.setEndPoint(endpoint);
            request.setMethod('GET');
            HttpResponse response = new HTTP().send(request);
        }
    }
*/
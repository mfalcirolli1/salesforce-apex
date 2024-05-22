trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    if(Trigger.isInsert || Trigger.isUpdate){
        if(Trigger.isAfter){
            
            List<Task> tasks = new List<Task>();

            for (Opportunity op : Trigger.new) {
                if(op.StageName == 'Closed Won'){
                    Task task = new Task();
                    Task.Subject = 'Follow Up Test Task';
                    Task.Whatid = op.Id;
                    tasks.add(task);
                }
            }

            if(tasks.size() > 0){
                insert tasks;
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
    switch on Trigger.operationType {
        when AFTER_INSERT {
            // do stuff
        }
        when AFTER_UPDATE {
            // do stuff
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
--
    Limites SOQL em Triggers
        * Apex Síncrono: 100 Consultas SOQL
        * Apex Assíncrono: 200 Consultas SOQL
--
     O limite da instrução DML é de 150 chamadas
*/
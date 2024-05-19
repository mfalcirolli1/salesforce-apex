trigger AccountTrigger on Account (before insert) {

    if(Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.CreateAccounts(Trigger.New);
    }
}

/*
    trigger TriggerName on ObjectName (trigger_events) {
    code_block
    } 

    before insert (antes de inserir)
    after insert (após inserir)

    before update (antes de atualizar)
    after update (após atualizar)

    before delete (antes de excluir)
    after delete (após excluir)

    after undelete (após desfazer exclusão)

    ** Se executar instruções DML (insert, update, delete) nesses registros, receberá um erro **

    Trigger.new --> Contém todos os registros que foram inseridos nos acionadores de inserção ou atualização
    Trigger.old --> Fornece a versão antiga de sObjects antes de eles serem atualizados nos acionadores de atualização, ou uma lista de sObjects excluídos nos acionadores de exclusão
*/
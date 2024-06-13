# Steps

1. Connect to Org.
2. To create a project: Ctrl+Shift+P > SFDX: Create Project > Standard project template (default)
3. To create classes: Create a folder > Right-click the folder > SFDX: Create Apex Class.
4. Right-click the folder 'classes', then choose SFDX: Deploy Source To Org.
5. Ctrl+Shift+P > SFDX: Run Apex Tests. > Choose Test File
6. SFDX: Toggle Checkpoint > To set Checkpoint.
7. SFDX: Update Checkpoints in Org > To tell Salesforce about your checkpoints.
8. SFDX: Turn On Apex Debug Log for Replay Debugger. To enable debug logs.
9. SFDX: Run Apex Tests > Choose Test File.
10. SFDX: Get Apex Debug Logs > To get a debug log.
11. Click any line in the debug log > Choose SFDX: Launch Apex Replay Debugger with Current File.
12. If the file is modified, click any line in the file, then choose SFDX: Deploy This Source to Org.

# Notas Importantes

* Apex não diferencia maiúsculas de minúsculas
* Apex e o banco de dados da plataforma do Lightning estão intimamente ligados
* A maioria dos padrões de design .NET não funciona na plataforma do Lightning
* Testes de unidade são obrigatórios. Precisa ter uma cobertura de teste de 75% para implantar seu código do Apex em uma organização de produção
* Não existem arquivos de solução, projeto ou configuração
* Não é preciso se preocupar com a autenticação ou com o armazenamento de senhas e sequências de caracteres para conexão com o banco de dados
* Para transformar um método de processamento síncrono em processamento assíncrono basta acrescentar a anotação @future ao método. Garantir que o método é estático e void
* Métodos futuros precisam ter parâmetros de dados primitivos. Não podem considerar objetos como parâmetros
* Não é possível encadear métodos futuros e fazer com que um chame o outro
* Usar o processamento assíncrono quando: Precisar fazer callouts para serviços web externos; Processar grande número de registros; XP de usuário melhor e mais rápida
* Cada registro de depuração tem de ter até 20 MB
* Cada organização pode reter até 1.000 MB de registros de depuração (os registros mais antigos são substituídos)

# DML (Data Manipulation Language)

* insert (inserir)
* update (atualizar)
* upsert (inserir e atualizar)
* delete (excluir)
* undelete (desfazer exclusão)
* merge (mesclar)

* DML Exception --> catch (DmlException e)

* Métodos Database possuem um parâmetro allOrNone opcional, que permite que especifique se a operação pode ser parcialmente bem-sucedida (Database.insert(recordList, false);).
* Por padrão, o parâmetro allOrNone é definido como 'true'. (Database.insert(recordList); == Database.insert(recordList, true);)
* Os métodos Database retornam objetos de resultado contendo informações de sucesso ou falha para cada registro.

```apex
Database.SaveResult[] srList = Database.insert(conList, false);
for (Database.SaveResult sr : srList) {
    if (sr.isSuccess()) {
        System.debug('Successfully inserted contact. Contact ID: ' + sr.getId());
    } else {
        for(Database.Error err : sr.getErrors()) {
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Contact fields that affected this error: ' + err.getFields());
	 }
    }
}
```

# Níveis de Registro

* NONE (NENHUM)
* ERROR (ERRO)
* WARN (AVISO)
* INFO (INFORMAÇÕES)
* DEBUG (DEPURAÇÃO)
* FINE (BOM)
* FINER (ÓTIMO)
* FINEST (MELHOR)

# LWC - Lightning Web Components

* Os componentes Web do Lightning usam os principais padrões de Componentes Web e fornecem apenas o que é necessário para um bom desempenho em navegadores compatíveis com o Salesforce.
* A maior parte do código usado é JavaScript e HTML padrão.
* A vantagem de aderir aos padrões da Web é a simplicidade. Não é necessário aprender a usar as peculiaridades de uma estrutura específica. Basta criar componentes usando HTML, JavaScript e CSS.
* Etapas:
    1. Criar um arquivo JavaScript
    2. Criar um arquivo HTML
    3. Opcionalmente, criar um arquivo CSS
* Componentes Web do Lightning e os Componentes do Aura funcionam juntos
* Biblioteca de componentes do Lightning:
    1. http://<MyDomainName>.lightning.force.com/docs/component-library
    2. https://developer.salesforce.com/docs/component-library/overview/components.
    3. https://github.com/trailheadapps/ebikes-lwc
    4. Extension VS Code: Salesforce Extension Pack
    5. Lightning Data Service (LDS): https://developer.salesforce.com/docs/platform/lwc/guide/data-ui-api?_ga=2.58323887.46376943.1715208361-164224861.1712974007

# Comandos

* command -flag arguments
* Criar novo projeto: sf project generate -n MyProject
* Criar org temporária: sf org create scratch -f project-scratch-def.json -d
* Criar diretório: mkdir Resume
* Mudar diretório: cd Documents (change directory)
* Ver histórico de comandos: F7
* Instalar extensão: Salesforce Extension Pack
* npm install npm@latest -g

# Métodos Futuros (@future)

* Métodos futuros tem que ser estáticos
* Só podem retornar um tipo 'void'
* São utilizados para fazer callouts para serviços da Web externos
* Os parâmetros especificados precisam ser tipos de dados primitivos, matrizes de tipos de dados primitivos ou coleções de tipos de dados primitivos

> * O motivo de os objetos não poderem ser passados como argumentos para métodos futuros é que o objeto pode mudar entre o momento em que o método é chamado e o momento em que ele é realmente executado
> * Métodos Futuros são executados quando os recursos do sistema se tornam disponíveis
> * Não é garantido que métodos futuros sejam executados na mesma sequência em que foram chamados
> * Também é possível que dois métodos futuros possam ser executados simultaneamente

```apex
public class SomeClass {
  @future
  public static void someFutureMethod(List<Id> recordIds) {
    List<Account> accounts = [Select Id, Name from Account Where Id IN :recordIds];
    // process account records to do awesome stuff
  }
}
```

# Queueable Apex

* Para usar o Apex que permite a execução em fila, basta implementar a interface Queueable
* A classe Queueable pode conter variáveis membro de tipos de dados não primitivos, como sObjects ou tipos personalizados do Apex
* É possível adicionar até 50 trabalhos à fila com o System.enqueueJob em uma só transação
* Apenas um trabalho filho pode existir para cada trabalho pai que permite a execução em fila
* Para as versões 'Developer Edition' e 'Trial orgs', a profundidade máxima da pilha para trabalhos encadeados é de 5

```apex
public class SomeClass implements Queueable {
    public void execute(QueueableContext context) {
        // awesome code here
    }
}
```

```apex
public class UpdateParentAccount implements Queueable {
    private List<Account> accounts;
    private ID parent;
    public UpdateParentAccount(List<Account> records, ID id) {
        this.accounts = records;
        this.parent = id;
    }
    public void execute(QueueableContext context) {
        for (Account account : accounts) {
          account.parentId = parent;
          // perform other processing or callout
        }
        update accounts;
    }
}
```

* Para adicionar uma classe como um trabalho na fila, executar o seguinte código:

```apex
// Obter parâmetros
List<Account> accounts = [select id from account where billingstate = ‘NY’];
Id parentId = [select id from account where name = 'ACME Corp'][0].Id;

// Instanciar a classe Queueable
UpdateParentAccount updateJob = new UpdateParentAccount(accounts, parentId);
ID jobID = System.enqueueJob(updateJob);
```

* Após enviar a classe Queueable para a execução, o trabalho será adicionado à fila e processado quando os recursos do sistema se tornarem disponíveis

```apex
SELECT Id, Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :jobID
```

* Encadear trabalhos

```apex
public class FirstJob implements Queueable {
    public void execute(QueueableContext context) {
        // Chain this job to next job by submitting the next job
        System.enqueueJob(new SecondJob());
    }
}
```

# Apex de lote

* A classe tem de implementar a interface Database.Batchable e incluir os três métodos a seguir: Start, Execute, Finish
*  Cada execução de um trabalho do Apex de lote é considerada uma **operação discreta**

```apex
public class MyBatchClass implements Database.Batchable<sObject> {
    public (Database.QueryLocator | Iterable<sObject>) start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
    }
    public void execute(Database.BatchableContext bc, List<P> records){
        // process each batch of records
    }
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}
```

* Como invocar uma classe de lote

```apex
MyBatchClass myBatchObject = new MyBatchClass();
Id batchId = Database.executeBatch(myBatchObject, 100);
```

* Cada invocação do Apex de lote cria um registro AsyncApexJob para que possa acompanhar o progresso do trabalho

```apex
AsyncApexJob job = [SELECT Id, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors FROM AsyncApexJob WHERE ID = :batchId ];
```

```apex
public class UpdateContactAddresses implements
    Database.Batchable<sObject>, Database.Stateful {
    // instance member to retain state across transactions
    public Integer recordsProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
            'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
            'MailingState, MailingPostalCode FROM Contacts) FROM Account ' +
            'Where BillingCountry = \'USA\''
        );
    }

    public void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                // add contact to list to be updated
                contacts.add(contact);
                // increment the instance member counter
                recordsProcessed = recordsProcessed + 1;
            }
        }
        update contacts;
    }

    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        EmailUtils.sendMessage(job, recordsProcessed);
    }
}
```

# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)

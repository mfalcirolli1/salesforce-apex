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

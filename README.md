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

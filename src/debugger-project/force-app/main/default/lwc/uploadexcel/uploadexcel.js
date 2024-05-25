import { LightningElement, track } from 'lwc';
import readExcelFile from '@salesforce/apex/ExcelController.readExcelFile';

import { loadScript } from 'lightning/platformResourceLoader';
import xlsx from '@salesforce/resourceUrl/xlsx';
// Setup > Custom Code > Static Resources > New > Name = xlsx > Upload arquivo > public
// TODO: Adicionar validacao de extecao
// TODO: Verificar se o registro já está cadastrado antes de inserir

export default class ExcelFileUploader extends LightningElement {
    @track isUploadDisabled = true;
    file;
    xlsxLibraryLoaded = false;
    success = false;
    mensagemResultado = '';
    nomeArquivo;
    quantidadeRegistros;

    connectedCallback() {
        loadScript(this, xlsx)
        .then(() => {
            this.xlsxLibraryLoaded = true;
            console.log('XLSX carregado')
        }).catch(error => {
            console.error('Error loading xlsx library', error);
        });
    }

    handleFileChange(event) {
        this.file = event.target.files[0];
        this.isUploadDisabled = !this.file;
        this.nomeArquivo = this.file.name;
        console.log('Upload do arquivo: ' + this.file.name)
    }

    async uploadFile() {
        console.log('Iniciando upload...')

        if (this.file) {
            try{
                console.log('Arquivo identificado...')
    
                const fileContent = await this.readFileContent(this.file);
                console.log(fileContent);
                const workbook = XLSX.read(fileContent, { type: 'binary' });
                const sheetName = workbook.SheetNames[0];
                const sheet = workbook.Sheets[sheetName];
                const jsonData = XLSX.utils.sheet_to_json(sheet);
                
                this.quantidadeRegistros = jsonData.length;
                console.log('Registros identificados: ' + JSON.stringify(jsonData));

                await readExcelFile({ data: JSON.stringify(jsonData) });
            }
            catch(error){
                this.mensagemResultado = 'Error no upload do arquivo: ' + error;
                console.error('Error no upload do arquivo', error);
            }
        }
        this.success = true;
    }

    readFileContent(file) {
        return new Promise((resolve, reject) => {
            const reader = new FileReader();

            // Leitura do arquivo
            reader.readAsBinaryString(file);

            // Callback de sucesso
            reader.onload = () => resolve(reader.result);
            // Callback de erro
            reader.onerror = error => reject(error);
        });
    }
}
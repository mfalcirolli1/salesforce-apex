import { LightningElement, api, track, wire } from 'lwc';
import ReturnAllContacts from '@salesforce/apex/CepAPI.ReturnAllContacts'

export default class Consultacepcontainer extends LightningElement {

    @track error;
    @track contacts = [];
    contactSelected = false;

    connectedCallback() {
        this.handleBuscarContatos();
    }

    handleBuscarContatos(){

        ReturnAllContacts()
          .then(result => {

            console.log(result);

            this.contacts = result.map(contact => {
                return { label: contact.Name, value: contact.Id };
            });

            this.error = undefined;
          })
          .catch( error => {
            this.error = error;
            this.contacts = [];
            console.error('Erro ao chamar método Apex:', error);
          });
    }
    

    handleContactSelected(){
        this.contactSelected = true;
    }
}

/*
@wire(ReturnAllContacts)
    getContatos({error, data}) {

        if(data){
            console.log(data);

            this.contacts = data.map(contact => {
                return { label: contact.Name, value: contact.Id };
            });
            this.error = undefined;

        } else if (error) {
            this.error = error;
            this.contacts = [];
        }
    }
*/
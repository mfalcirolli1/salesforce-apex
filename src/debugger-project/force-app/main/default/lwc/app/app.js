// A instrução 'import' indica que o JavaScript usa a funcionalidade 'LightningElement' no módulo 'lwc'
// O 'LightningElement' é a classe básica dos componentes Web do Lightning que permite usar connectedCallback()
import { LightningElement, wire, api, track } from 'lwc';
import ReturnAddressByCep from '@salesforce/apex/CepAPI.ReturnAddressByCep'

// 'export': Define uma classe que estende a classe LightningElement

export default class App extends LightningElement {

  ready = false;
  
  @track address;
  @track cep;
  @track error;

  handleInputCepChange(event){
    this.cep = event.target.value;
    console.log(this.cep);
  }

  handleBuscarEndereco(){

    console.log("Entrei na busca");
    
    const regex = /^\d{8}$/;
    if (!regex.test(this.cep)) {
        alert('O CEP deve conter 7 dígitos e apenas números!');
        return;
    }

    ReturnAddressByCep({cep: this.cep})
      .then(result => {

        this.ready = true;
        this.address = result;
        this.error = undefined;
      })
      .catch( error => {
        this.error = error;
        console.error('Erro ao chamar método Apex:', error);
      });
  }

  handleResetarEndereco(){
    let cep = this.template.querySelector("lightning-input");
    cep.value = '';
    this.ready = false;
  }

  //@wire(ReturnAddressByCep, {cep: '$cep'}) address;

  // get endereco(){
  //   return this.address.data;
  // }

  // name = 'Electra X4';
  // description = 'A sweet bike built for comfort.';
  // category = 'Mountain';
  // material = 'Steel';
  // price = '$2,700';
  // pictureUrl = 'https://s3-us-west-1.amazonaws.com/sfdc-demo/ebikes/electrax4.jpg';
  // ready = false;

  // connectedCallback() {
  //   setTimeout(() => {
  //     this.ready = true;
  //   }, 3000);
  // }
}

// :: Ganchos de ciclo de vida ::
// Os LWCs oferecem métodos que permitem conectar o códgio a eventos críticos no ciclo de vida de um componente
// Momento em que um componente é:
    // Criado:
    // Adicionado ao DOM: connectedCallback()
    // Removido do DOM: disconnectedCallback()
    // Renderizado no navegador:
    // Encontra erros:

// :: Decoradores ::
// Usados em JavaScript para modificar o comportamento de uma propriedade ou função
// Para usar um decorador, importe-o do módulo lwc e coloque-o antes da propriedade ou função (import { LightningElement, api } from 'lwc';)
// Uma única propriedade ou função pode ter apenas um decorador. Por exemplo, uma propriedade não pode ter decoradores @api e @wire
// @api: Marca um campo como público. Propriedades públicas definem a API de um componente
// Em um componente Web do Lightning, apenas os campos que um autor de componente decora com @api estão publicamente disponíveis para os consumidores como propriedades do objeto
// @track: Diz à estrutura para considerar alterações nas propriedades de um objeto ou nos elementos de uma matriz. Se ocorrer uma alteração, a estrutura renderizará o componente novamente
// @wire: Oferece uma maneira fácil de obter e vincular dados de uma organização do Salesforce
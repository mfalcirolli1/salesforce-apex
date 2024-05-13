import { LightningElement, api } from 'lwc';

export default class Tile extends LightningElement {
    @api product;

    tileClick() {
        const event = new CustomEvent('tileclick', {
            // detail contains only primitives
            detail: this.product.fields.Id.value
        });
        // Fire the event from c-tile
        this.dispatchEvent(event);
    }
}

/* 

:: Transmitir informações para cima ::
    Transmitidas usando eventou e ouvintes de eventos

    Componente filho (tile) contém um método tileClick() que cria um Objeto de Evento usando CustomEvent() e envia o tipo de evento 'tileclick'
    quando o usuário clica em um botão
    O componente pai (list) ouve o evento com o manipulador de eventos prefixado com 'on' (ontileclick)

    Quando um usuário clica em uma das instâncias de blocos na interface do usuário, 
    o ouvinte onclick chama a função tileClick do manipulador no arquivo JavaScript tile.js.

:: Transmitir informações para baixo ::

    Transmitidas usando propriedades públicas e métodos públicos

    Crie uma propriedade pública no JavaScript do Componente filho (tile) com o Decorador @api
    Defina o valor da propriedade no HTML do Componente pai (list) após o nome do componente 'c-componente'
    Ex:     @api itemName;      <c-todo-item item-name="Milk"></c-todo-item>
    O atributo item-name no HTML mapeia para a propriedade itemName do JavaScript.

    Também é possível criar métodos públicos que podem ser chamados a partir de um componente pai
    Crie um método público no componente filho definindo-o com o decorador @api
    em seguida, chame-o do componente pai.

    _Pai
    import { LightningElement } from 'lwc';
    export default class MethodCaller extends LightningElement {
    handlePlay() {
        this.template.querySelector('c-video-player').play();
    }
    }

    _Filho
    import { LightningElement, api } from 'lwc';
    export default class VideoPlayer extends LightningElement {
    @api play() {
        // Play music!
    }
    }

*/
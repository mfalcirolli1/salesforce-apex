import { LightningElement, wire } from 'lwc';

import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name';

import FahrenheitToCelsius from '@salesforce/apex/TemperatureConverter.FahrenheitToCelsius'
import ObterPrimeiraConta from '@salesforce/apex/AccountTriggerHandler.ObterPrimeiraConta';

const fields = [NAME_FIELD];

export default class Selector extends LightningElement {
    selectedProductId;

    handleProductSelected(evt) {
        this.selectedProductId = evt.detail;
    }

    userId = Id;
    @wire(getRecord, {recordId: '$userId', fields: fields}) user;

    get name(){
        return getFieldValue(this.user.data, NAME_FIELD);
    }

    @wire(FahrenheitToCelsius, {fh: 232.76}) temp;

    get temperatura(){
        return this.temp.data;
    }

    @wire(ObterPrimeiraConta, {billingState: 'CA'}) account;
    
    get conta(){
        return this.account.data;
    }
}

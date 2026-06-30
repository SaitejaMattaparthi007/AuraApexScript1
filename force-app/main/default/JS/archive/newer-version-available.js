import { LightningElement } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

// Using a deprecated version of the wire adapter
export default class MyComponent extends LightningElement {
    @wire(getRecord, { recordId: '$recordId', fields: ['Account.Name'] })
    account;
}
import { LightningElement } from 'lwc';

export default class Foo extends LightningElement {
    connectedCallback() {
        if (process.env.NODE_ENV !== 'production') {
            console.log('Foo:connectedCallback');
        }
    }
}
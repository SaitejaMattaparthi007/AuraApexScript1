import { LightningElement } from 'lwc';

export default class Foo extends LightningElement {
    connectedCallback() {
        if (!import.meta.env.SSR && process.env.NODE_ENV !== 'production') {
            console.log('Foo:connectedCallback');
        }
    }
}
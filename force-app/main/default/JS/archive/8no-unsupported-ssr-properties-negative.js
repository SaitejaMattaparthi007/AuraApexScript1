import { LightningElement } from 'lwc';

export default class Foo extends LightningElement {
    connectedCallback() {
        this.querySelector('span')?.getAttribute?.('role');
    }

    connectedCallback() {
        this.dispatchEvent(new CustomEvent('customevent'));
    }
}
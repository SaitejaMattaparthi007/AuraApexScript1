import { LightningElement } from 'lwc';
import tmplA from './a.html';

export default class Foo extends LightningElement {
    connectedCallback() {
        // we can't use window here
    }

    renderedCallback() {
        window.foo = true;
    }

    bar() {
      this.template.classList.add('foo');
    }


    // invalid
    constructor() {
        console.log(globalThis.document.x);
    }
    url = window.location.href;

    get url() {
        return window.location.href;
    }
}
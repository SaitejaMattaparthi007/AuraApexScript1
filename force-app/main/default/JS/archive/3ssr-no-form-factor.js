// valid
import { LightningElement } from 'lwc';
import { formFactor } from '@salesforce/client/formFactor';
                   
    class MyComponent extends LightningElement {
}


// invalid
export default class MyComponent3 extends LightningElement {
    connectedCallback() {
        console.log(formFactor);
    }
}

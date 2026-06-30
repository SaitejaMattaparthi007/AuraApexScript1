// valid
import { LightningElement } from 'lwc';
import userId from '@salesforce/user/Id';
                   
class MyComponent extends LightningElement {
}


// invalid 
export default class Foo extends LightningElement {
    connectedCallback() {
        console.log(userId);
    }
}
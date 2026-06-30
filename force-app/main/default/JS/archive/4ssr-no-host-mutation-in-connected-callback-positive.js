// valid
import { LightningElement } from 'lwc';
export default class Cmp extends LightningElement {
    @api fromOutside;
    get theClassMyChildNeeds() {
    return `my-child-needs-${this.fromOutside}`;
    }
}
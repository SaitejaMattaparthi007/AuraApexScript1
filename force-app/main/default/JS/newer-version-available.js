import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class DeprecatedApiTest extends NavigationMixin(LightningElement) {

    connectedCallback() {
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '001000000000001AAA',
                actionName: 'view'
            }
        }).then(url => {
            console.log(url);
        });
    }
}

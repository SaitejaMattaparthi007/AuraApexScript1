// file: force-app/main/default/lwc/ssrComponent/ssrComponent.js
import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import tmpl from './ssrComponent.html';

export default class SsrComponent extends NavigationMixin(LightningElement) {
    render() {
        return tmpl;
    }
    navigate() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: { recordId: '001xx000003DGbY', actionName: 'view' }
        });
    }
}

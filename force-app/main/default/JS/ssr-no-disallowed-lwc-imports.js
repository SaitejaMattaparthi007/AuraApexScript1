// ❌ VIOLATION: Importing disallowed modules in SSR context
// File: disallowedImports.js
import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadScript } from 'lightning/platformResourceLoader';

export default class DisallowedImports extends NavigationMixin(LightningElement) {
    navigateToRecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '001xx000003DGbYAAW',
                actionName: 'view'
            }
        });
    }

    showToast() {
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message: 'Record updated',
            variant: 'success'
        }));
    }
}

import { LightningElement } from 'lwc';
import { openTab } from 'lightning/platformWorkspaceApi';

export default class WorkspaceExample extends LightningElement {
    async connectedCallback() {
        await openTab({
            recordId: '001xx000003DGbYAAW'
        });
    }
}

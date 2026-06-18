import { getRecordNotifyChange } from 'lightning/uiRecordApi';

export default class TestClass {
    test() {
        getRecordNotifyChange([
            { recordId: '001000000000001AAA' }
        ]);
    }
}

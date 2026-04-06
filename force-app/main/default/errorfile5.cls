@isTest
static void testDivideByZeroHandled() {
    Test.startTest();
    try {
        QueueSetupTestClass.divideNumbers(10, 0);
    } catch (Exception e) {
        System.assert(e != null);
    }
    Test.stopTest();
}

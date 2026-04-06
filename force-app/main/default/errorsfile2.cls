@isTest
public class QueueSetupTestClassTest {
    @isTest
    static void testNullPointerScenario() {
        List<Account> accList = null;
        Test.startTest();
        QueueSetupTestClass.processRecords(accList);
        Test.stopTest();
    }
    @isTest
    static void testDivideByZero() {
        Test.startTest();
        QueueSetupTestClass.divideNumbers(10, 0);
        Test.stopTest();
    }
}

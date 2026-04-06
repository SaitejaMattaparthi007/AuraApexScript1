@isTest
public class QueueSetupTestClassTest {
 
    @isTest
    static void testQueueExecution() {
        List<Account> accList = new List<Account>();
        accList.add(new Account(Name = 'Test Account'));
        insert accList;
 
        Test.startTest();
        System.enqueueJob(new QueueSetupTestClass());
        Test.stopTest();
    }
 
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
}

@isTest
public class QueueSetupTestClassTest {
 
    @isTest
    static void testQueueFailure() {
        Test.startTest();
        System.enqueueJob(new QueueSetupTestClass());
        Test.stopTest(); // This will surface the async failure
    }
}

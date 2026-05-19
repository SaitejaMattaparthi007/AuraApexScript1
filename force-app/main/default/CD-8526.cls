/**
 * Test Apex File for SOQL In Loops Rule
 * Parameter: checkInternalSoql = true
 *
 * Purpose:
 * Validate detection of hidden/internal SOQL consuming methods used inside loops.
 */

public class InternalSoqlLoopTest {

    public static void executeTests() {

        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 5];
        List<Contact> contacts = [SELECT Id, Email FROM Contact LIMIT 5];

        Id templateId = '00X000000000001'; // Dummy Email Template Id

        /*
         * =========================================================
         * TD-01 : Messaging.renderStoredEmailTemplate()
         * =========================================================
         */
        for(Contact c : contacts) {
            Messaging.renderStoredEmailTemplate(templateId, c.Id, null);
        }

        /*
         * =========================================================
         * TD-02 : Messaging.renderEmailTemplate()
         * =========================================================
         */
        for(Contact c : contacts) {
            Messaging.renderEmailTemplate(templateId, c.Id, null);
        }

        /*
         * =========================================================
         * TD-03 : Messaging.sendEmail()
         * =========================================================
         */
        for(Contact c : contacts) {
            Messaging.SingleEmailMessage mail =
                new Messaging.SingleEmailMessage();

            mail.setTargetObjectId(c.Id);

            Messaging.sendEmail(
                new Messaging.SingleEmailMessage[] { mail }
            );
        }

        /*
         * =========================================================
         * TD-04 : UserInfo.getName()
         * =========================================================
         */
        for(Account a : accounts) {
            String username = UserInfo.getName();
        }

        /*
         * =========================================================
         * TD-05 : Other UserInfo Methods
         * =========================================================
         */
        for(Account a : accounts) {

            UserInfo.getFirstName();

            UserInfo.getLastName();

            UserInfo.getEmail();

            UserInfo.getUserType();

            UserInfo.getProfileId();

            UserInfo.getSessionId();
        }

        /*
         * =========================================================
         * TD-06 : FeatureManagement.checkPermission()
         * =========================================================
         */
        for(Account a : accounts) {
            FeatureManagement.checkPermission('CustomPermission');
        }

        /*
         * =========================================================
         * TD-07 : Approval.process()
         * =========================================================
         */
        for(Account a : accounts) {

            Approval.ProcessSubmitRequest req =
                new Approval.ProcessSubmitRequest();

            req.setObjectId(a.Id);

            Approval.process(req);
        }

        /*
         * =========================================================
         * TD-08 : Approval.lock() / unlock()
         * =========================================================
         */
        for(Account a : accounts) {

            Approval.lock(a.Id);

            Approval.unlock(a.Id);
        }

        /*
         * =========================================================
         * TD-09 : Flow.Interview.start()
         * =========================================================
         */
        for(Account a : accounts) {

            Flow.Interview.SampleFlow flowObj =
                new Flow.Interview.SampleFlow(
                    new Map<String, Object>()
                );

            flowObj.start();
        }

        /*
         * =========================================================
         * TD-10 : ConnectApi.*
         * =========================================================
         */
        for(Account a : accounts) {

            ConnectApi.ChatterFeeds.getFeedItemsFromFeed(
                null,
                ConnectApi.FeedType.Record,
                a.Id
            );
        }

        /*
         * =========================================================
         * TD-11 : PageReference.getContent()
         * =========================================================
         */
        for(Account a : accounts) {

            Blob pageContent = Page.MyPage.getContent();
        }

        /*
         * =========================================================
         * TD-12 : PageReference.getContentAsPDF()
         * =========================================================
         */
        for(Account a : accounts) {

            Blob pdfContent = Page.MyPage.getContentAsPDF();
        }

        /*
         * =========================================================
         * TD-13 : Existing Explicit SOQL In Loop
         * =========================================================
         */
        for(Account a : accounts) {

            List<Contact> relatedContacts = [
                SELECT Id
                FROM Contact
                WHERE AccountId = :a.Id
            ];
        }

        /*
         * =========================================================
         * NEGATIVE TESTS
         * =========================================================
         */

        // Outside loop — should NOT be flagged
        Messaging.renderStoredEmailTemplate(
            templateId,
            contacts[0].Id,
            null
        );

        // Cached UserInfo outside loop
        String uname = UserInfo.getName();

        for(Account a : accounts) {
            System.debug(uname);
        }

        // Method call before loop
        Messaging.RenderEmailTemplateBodyResult result =
            Messaging.renderStoredEmailTemplate(
                templateId,
                contacts[0].Id,
                null
            );

        for(Account a : accounts) {
            System.debug(result);
        }
    }
}

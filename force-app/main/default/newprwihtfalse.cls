public class InternalSoqlInLoopRuleTest {

    public static void testInternalSoqlMethods() {

        List<Account> accounts = [SELECT Id FROM Account LIMIT 5];
        List<Contact> contacts = [SELECT Id FROM Contact LIMIT 5];

        Id templateId = '00X000000000000AAA';

        // Messaging.renderStoredEmailTemplate()
        for (Contact c : contacts) {
            Messaging.renderStoredEmailTemplate(templateId, c.Id, null);
        }

        // Messaging.renderEmailTemplate()
        for (Contact c : contacts) {
            Messaging.renderEmailTemplate(templateId, c.Id, null);
        }

        // Messaging.sendEmail()
        for (Contact c : contacts) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setTargetObjectId(c.Id);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        }

        // UserInfo.getName()
        for (Account a : accounts) {
            String userName = UserInfo.getName();
        }

        // UserInfo.getFirstName()
        for (Account a : accounts) {
            String firstName = UserInfo.getFirstName();
        }

        // UserInfo.getLastName()
        for (Account a : accounts) {
            String lastName = UserInfo.getLastName();
        }

        // UserInfo.getEmail()
        for (Account a : accounts) {
            String email = UserInfo.getEmail();
        }

        // UserInfo.getUserType()
        for (Account a : accounts) {
            String userType = UserInfo.getUserType();
        }

        // UserInfo.getProfileId()
        for (Account a : accounts) {
            Id profileId = UserInfo.getProfileId();
        }

        // UserInfo.getSessionId()
        for (Account a : accounts) {
            String sessionId = UserInfo.getSessionId();
        }

        // FeatureManagement.checkPermission()
        for (Account a : accounts) {
            Boolean hasPermission = FeatureManagement.checkPermission('CustomPermission');
        }

        // Approval.process()
        for (Account a : accounts) {
            Approval.ProcessSubmitRequest request = new Approval.ProcessSubmitRequest();
            request.setObjectId(a.Id);
            Approval.process(request);
        }

        // Approval.lock()
        for (Account a : accounts) {
            Approval.lock(a.Id);
        }

        // Approval.unlock()
        for (Account a : accounts) {
            Approval.unlock(a.Id);
        }

        // Flow.Interview.start()
        for (Account a : accounts) {
            Flow.Interview.SampleFlow flowInstance =
                new Flow.Interview.SampleFlow(new Map<String, Object>());
            flowInstance.start();
        }

        // ConnectApi.* method
        for (Account a : accounts) {
            ConnectApi.ChatterFeeds.getFeedItemsFromFeed(
                null,
                ConnectApi.FeedType.Record,
                a.Id
            );
        }

        // System.PageReference.getContent()
        for (Account a : accounts) {
            Blob pageBody = Page.MyPage.getContent();
        }

        // System.PageReference.getContentAsPDF()
        for (Account a : accounts) {
            Blob pdfBody = Page.MyPage.getContentAsPDF();
        }
    }
}

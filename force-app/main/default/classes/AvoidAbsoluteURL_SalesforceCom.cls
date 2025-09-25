// Demonstrates violations for *.salesforce.com
public with sharing class AvoidAbsoluteURL_SalesforceCom {
    public static void runExamples() {
        // VIOLATION: absolute URL to *.salesforce.com
        String endpoint1 = 'https://mydomain.salesforce.com/services/data/v59.0/query?q=SELECT+Id+FROM+Account';

        // VIOLATION: absolute URL to login.salesforce.com
        String endpoint2 = 'HTTPS://login.salesforce.com/services/oauth2/token'; // mixed-case scheme

        // VIOLATION: protocol-relative absolute URL
        String endpoint3 = '//test.salesforce.com/ui/setup/SetupOneHome/d';

        // VIOLATION embedded in PageReference
        PageReference pr = new PageReference('https://mydomain.salesforce.com/apex/MyPage');

        // VIOLATION used in callout
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://na99.salesforce.com/services/data/v59.0/limits');
        HttpResponse res = h.send(req);

        // Safe usage example (relative) — SHOULD NOT trigger the rule
        String relative = '/services/data/v59.0/sobjects/Contact';
        System.debug(relative);
    }
}

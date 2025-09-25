// Demonstrates violations for *.marketingcloudapis.com
public with sharing class AvoidAbsoluteURL_MarketingCloudApisCom {
    public static void runExamples() {
        // VIOLATION: absolute URL to *.marketingcloudapis.com
        String mc1 = 'https://mc.exacttargetapis.com/data/v1/customobjects';

        // VIOLATION: generic subdomain with http
        String mc2 = 'http://abc.marketingcloudapis.com/contacts/v1/resolve?id=123';

        // VIOLATION in callout with headers
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer 00Dxx00000!AQEAQ...');
        req.setEndpoint('https://eu3.marketingcloudapis.com/interaction/v1/events');
        Http h = new Http();
        HttpResponse res = h.send(req);
    }
}

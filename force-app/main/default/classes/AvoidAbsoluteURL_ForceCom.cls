// Demonstrates violations for *.force.com
public with sharing class AvoidAbsoluteURL_ForceCom {
    public static void runExamples() {
        // VIOLATION: absolute URL to *.force.com
        String url1 = 'https://myapp.force.com/apex/CustomPage';

        // VIOLATION: subdomain
        String url2 = 'http://community.force.com/home?ref=abc';

        // VIOLATION: deeper subdomain
        String url3 = 'https://partners.force.com/portal/login';

        // Used in PageReference
        PageReference pr = new PageReference('https://portal.force.com/profile');

        // Used in callout
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://support.force.com/services/apexrest/v1/case');
        req.setBody('{"subject":"Test absolute URL","origin":"Phone"}');
        Http h = new Http();
        HttpResponse res = h.send(req);
    }
}

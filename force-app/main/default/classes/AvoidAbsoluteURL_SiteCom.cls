// Demonstrates violations for *.site.com
public with sharing class AvoidAbsoluteURL_SiteCom {
    public static void runExamples() {
        // VIOLATION: absolute URL to *.site.com
        String portal = 'https://mybrand.site.com/homepage';

        // VIOLATION: protocol-relative
        String help = '//portal.site.com/help?topic=usage';

        // VIOLATION in callout
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('http://docs.site.com/api/v1/info');
        Http h = new Http();
        HttpResponse res = h.send(req);
    }
}

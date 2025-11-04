public class PIIFieldTestHandler {
    public String customerName;
    public String customerEmail;
    public String phoneNumber;
    public String ssn; // Social Security Number
    public String panNumber; // PAN (India)
    public String creditCardNumber; // Sensitive
    public String homeAddress;
    public String dateOfBirth;

    public void processCustomerData() {
        // Logging sensitive info (bad practice)
        System.debug('Processing customer: ' + customerName);
        System.debug('Email: ' + customerEmail);
        System.debug('Phone: ' + phoneNumber);
        System.debug('SSN: ' + ssn);

        // Storing sensitive info in a map
        Map<String, String> piiData = new Map<String, String>();
        piiData.put('email', customerEmail);
        piiData.put('ssn', ssn);
        piiData.put('dob', dateOfBirth);
    }
}

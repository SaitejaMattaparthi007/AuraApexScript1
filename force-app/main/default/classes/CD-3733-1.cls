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

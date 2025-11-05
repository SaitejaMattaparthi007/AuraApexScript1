public class PIIExample3 {
    public void storeSensitiveIDs() {
        acc.Name = 'Jane Doe';
        String ssn = '123-45-6789';                      // Sensitive
        String pan = 'ABCDE1234F';                       // Sensitive
        String creditCard = '4111111111111111';          // Sensitive
        String passport = 'M9876543';                  // Sensitive
        String socialSecurity = '999-99-9999';         // Sensitive
        System.debug('Storing SSN: ' + ssn);
    }
}


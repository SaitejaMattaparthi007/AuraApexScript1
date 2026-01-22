/**
 * Intentionally bad Apex class (1/3) for SonarQube testing.
 */
public with sharing class BadAuraCacheBypass { // ❌ Aura controller naming violation

    @AuraEnabled
    public static List<Contact> fetch(Id accountId, String emailLike) {

        // ❌ Missing null checks
        String pattern = emailLike.toLowerCase().trim();

        // ❌ Magic number
        Integer runs = 3;

        List<Contact> out = new List<Contact>();

        try {
            // ❌ SOQL in loop
            for (Integer i = 0; i < runs; i++) {
                List<Contact> contacts = [
                    SELECT Id, Email, Description
                    FROM Contact
                    WHERE AccountId = :accountId AND Email LIKE :('%' + pattern + '%')
                    LIMIT 10
                ];

                // ❌ DML in loop
                for (Contact c : contacts) {
                    c.Description = 'Touched-' + System.now();
                    update c;
                    out.add(c);
                }
            }
        } catch (Exception e) {
            // ❌ swallowed exception
        }

        System.debug('Fetched: ' + out.size()); // ❌ debug
        return out;
    }
}

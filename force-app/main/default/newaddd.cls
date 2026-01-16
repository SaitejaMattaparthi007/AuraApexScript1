/**
 * Intentionally bad Apex class for SonarQube testing.
 * Contains multiple maintainability, performance, and security violations.
 */
public with sharing class BadAuraUtilityService { // ❌ Aura controller naming violation

    @AuraEnabled
    public static Boolean execute(Id accId, Integer count, String field) {

        // ❌ Magic number
        Integer threshold = 10;

        // ❌ Missing null checks
        String f = field.toUpperCase();

        // ❌ Hardcoded credentials-like value
        String token = 'abc123-secret-token';

        // ❌ Inefficient string concatenation
        String buffer = '';
        for (Integer i = 0; i < threshold; i++) {
            buffer += 'X' + i;
        }

        try {
            // ❌ SOQL in loop
            for (Integer i = 0; i < count; i++) {

                List<Account> accounts = [
                    SELECT Id, Name, Phone
                    FROM Account
                    WHERE Id = :accId
                    LIMIT 1
                ];

                // ❌ Unsafe list access
                Account a = accounts[0];

                // ❌ DML inside loop
                a.Phone = buffer;
                update a;

                // ❌ Debug logging
                System.debug('Updated Account: ' + a.Name);
            }
        } catch (Exception e) {
            // ❌ Swallowing exception
        }

        return true;
    }
}

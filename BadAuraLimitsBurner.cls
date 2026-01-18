/**
 * Intentionally bad Apex class (3/3) for SonarQube testing.
 */
public with sharing class BadAuraLimitsBurner { // ❌ Aura controller naming violation

    @AuraEnabled
    public static Integer burn(Id accountId) {

        // ❌ Magic number
        Integer loops = 5;

        Integer count = 0;

        // ❌ String concatenation in loop
        String trace = '';
        for (Integer i = 0; i < loops; i++) {
            trace += 'T' + i + ';';
        }

        try {
            // ❌ SOQL in loop + DML in loop
            for (Integer i = 0; i < 2; i++) {
                Account a = [SELECT Id, Phone FROM Account WHERE Id = :accountId LIMIT 1];
                a.Phone = trace;
                update a;
                count++;
            }
        } catch (Exception e) {
            // ❌ swallowed exception
        }

        System.debug('Count: ' + count); // ❌ debug
        return count;
    }
}

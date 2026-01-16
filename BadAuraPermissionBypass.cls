/**
 * Intentionally bad Apex class demonstrating security violations.
 */
public without sharing class BadAuraPermissionBypass { // ❌ Aura controller naming violation

    @AuraEnabled
    public static void updateSensitive(Id userId, String newAlias) {

        // ❌ Hardcoded sensitive-like value
        String adminKey = 'ADMIN-OVERRIDE-KEY';

        try {
            // ❌ No CRUD/FLS checks
            User u = [
                SELECT Id, Alias
                FROM User
                WHERE Id = :userId
                LIMIT 1
            ];

            // ❌ Debugging sensitive data
            System.debug('Admin key used: ' + adminKey);

            // ❌ DML without permission checks
            u.Alias = newAlias;
            update u;

        } catch (Exception ex) {
            // ❌ Empty catch block
        }
    }
}

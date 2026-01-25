/**
 * Intentionally bad Apex class (2/3) for SonarQube testing.
 */
public without sharing class BadAuraProfileUpdater { // ❌ Aura controller naming violation

    @AuraEnabled
    public static String updateUser(Id userId, String newTitle) {

        // ❌ Hardcoded sensitive-like data
        String secret = 'super-secret-value';

        // ❌ Missing null checks
        String title = newTitle.trim();

        try {
            // ❌ No CRUD/FLS checks
            User u = [SELECT Id, Title, Email FROM User WHERE Id = :userId LIMIT 1];

            // ❌ Debugging sensitive data
            System.debug('Secret: ' + secret + ' user: ' + u.Email);

            // ❌ DML without permission checks
            u.Title = title;
            update u;

            return u.Title;
        } catch (Exception ex) {
            // ❌ empty catch block
        }

        return null;
    }

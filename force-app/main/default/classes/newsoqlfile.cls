// Intentionally vulnerable Apex to trigger SonarQube rule: sf:SOQLInjection
// DO NOT USE IN PRODUCTION.

public with sharing class Sonar_SOQLInjection_Demo {

    // Example 1: WHERE clause injection via direct concatenation
    public static List<Account> badWhereClause(String userInput) {
        String q = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + userInput + '%\'';
        return Database.query(q); // ❌ sf:SOQLInjection
    }

    // Example 2: Full filter fragment returned from a helper (untrusted)
    public static List<Account> badFilterFragment() {
        String filter = getFilterFromUser(); // could be: "IsDeleted = false OR Name LIKE '%'"
        String q = 'SELECT Id, Name FROM Account WHERE ' + filter;
        return Database.query(q); // ❌ sf:SOQLInjection
    }

    // Example 3: IN-clause injection (string-built list)
    public static List<Contact> badInClause(String csvIdsFromUser) {
        // user might pass: "('003...') OR Name LIKE '%'"
        String q = 'SELECT Id, Name FROM Contact WHERE Id IN (' + csvIdsFromUser + ')';
        return Database.query(q); // ❌ sf:SOQLInjection
    }

    // Example 4: ORDER BY injection
    public static List<Account> badOrderBy(String sortFieldFromUser) {
        String q = 'SELECT Id, Name FROM Account ORDER BY ' + sortFieldFromUser;
        return Database.query(q); // ❌ sf:SOQLInjection
    }

    // Example 5: LIMIT injection (string concatenation)
    public static List<Account> badLimit(String limitFromUser) {
        String q = 'SELECT Id, Name FROM Account LIMIT ' + limitFromUser;
        return Database.query(q); // ❌ sf:SOQLInjection
    }

    // Example 6: Object name/type injection (dynamic FROM)
    public static List<SObject> badObjectName(String sobjectApiNameFromUser) {
        String q = 'SELECT Id FROM ' + sobjectApiNameFromUser + ' LIMIT 10';
        return Database.query(q); // ❌ sf:SOQLInjection
    }

    // Example 7: Field list injection (dynamic SELECT list)
    public static List<SObject> badFieldList(String fieldsFromUser, String objectNameFromUser) {
        String q = 'SELECT ' + fieldsFromUser + ' FROM ' + objectNameFromUser + ' LIMIT 5';
        return Database.query(q); // ❌ sf:SOQLInjection
    }

    // Example 8: Date injection as raw string (not valueOf / bind)
    public static List<Opportunity> badDateFilter(String dateFromUser) {
        String q = 'SELECT Id, Name FROM Opportunity WHERE CloseDate >= ' + dateFromUser;
        return Database.query(q); // ❌ sf:SOQLInjection
    }

    // Example 9: LIKE injection without escaping quotes
    public static List<Case> badLikeNoEscape(String subjectFromUser) {
        String q = 'SELECT Id, Subject FROM Case WHERE Subject LIKE \'%' + subjectFromUser + '%\'';
        return Database.query(q); // ❌ sf:SOQLInjection
    }

    // Helper simulating an untrusted source (user-controlled input)
    private static String getFilterFromUser() {
        // Intentionally returns a raw fragment to keep this vulnerable for Sonar testing.
        return 'Name != null OR Name LIKE \'%\'';
    }
}

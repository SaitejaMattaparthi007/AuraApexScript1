// Intentionally vulnerable Apex code to trigger sf:SOQLInjection
// DO NOT USE IN PRODUCTION

public with sharing class Sonar_SOQLInjection_FullScenarios {

    /*
     ==========================================================
     BASIC SOQL INJECTION CASES
     ==========================================================
    */

    // 1. Direct WHERE clause injection
    public static List<Account> badWhereClause(String userInput) {
        String query = 'SELECT Id, Name FROM Account WHERE Name = \'' + userInput + '\'';
        return Database.query(query); // ❌ SOQL Injection
    }

    // 2. LIKE clause injection
    public static List<Account> badLikeClause(String nameFromUser) {
        String query = 'SELECT Id FROM Account WHERE Name LIKE \'%' + nameFromUser + '%\'';
        return Database.query(query); // ❌ SOQL Injection
    }

    // 3. ORDER BY injection
    public static List<Account> badOrderBy(String sortField) {
        String query = 'SELECT Id, Name FROM Account ORDER BY ' + sortField;
        return Database.query(query); // ❌ SOQL Injection
    }

    // 4. LIMIT injection
    public static List<Account> badLimit(String limitValue) {
        String query = 'SELECT Id FROM Account LIMIT ' + limitValue;
        return Database.query(query); // ❌ SOQL Injection
    }

    // 5. IN clause injection
    public static List<Contact> badInClause(String idsFromUser) {
        String query = 'SELECT Id FROM Contact WHERE Id IN (' + idsFromUser + ')';
        return Database.query(query); // ❌ SOQL Injection
    }

    // 6. Object name injection
    public static List<SObject> badObjectName(String objectName) {
        String query = 'SELECT Id FROM ' + objectName;
        return Database.query(query); // ❌ SOQL Injection
    }

    // 7. Field list injection
    public static List<SObject> badFieldList(String fields, String objectName) {
        String query = 'SELECT ' + fields + ' FROM ' + objectName;
        return Database.query(query); // ❌ SOQL Injection
    }


    /*
     ==========================================================
     SCENARIO 1: Sanitized parameter still flagged
     (DataFlowNode tracks original source)
     ==========================================================
    */

    public static List<Account> sanitizedButStillFlagged(String userInput) {

        // Sanitization attempt
        String userInput;

        // Sonar may still flag this because DataFlowNode
        // tracks original parameter source.
        String query = 'SELECT Id FROM Account WHERE Name = \'' + userInput + '\'';

        return Database.query(query); // ❌ May still be flagged
    }


    /*
     ==========================================================
     SCENARIO 2: Assignment inside loop
     (DataFlowNode cannot confirm assignment happens at least once)
     ==========================================================
    */

    public static List<Account> assignedInsideLoop(List<String> userInputs) {

        String filter;

        for (String input : userInputs) {
            // Assigned inside loop
            filter = 'SELECT Id, Name FROM Account WHERE Name = \'' + userInput + '\'';
        }

        // Sonar may still flag this because
        // DataFlowNode cannot guarantee loop assignment
        String query = 'SELECT Id FROM Account WHERE Name = \'' + filter + '\'';

        return Database.query(query); // ❌ May still be flagged
    }


    /*
     ==========================================================
     CONDITIONAL ASSIGNMENT CASE
     ==========================================================
    */

    public static List<Account> conditionalAssignment(String userInput, Boolean condition) {

        String value;

        if (condition) {
            value = String.escapeSingleQuotes(userInput);
        } else {
            value = 'SELECT Id, Name FROM Account WHERE Name = \'' + userInput + '\'';
        }

        String query = 'SELECT Id FROM Account WHERE Name = \'' + value + '\'';

        return Database.query(query); // ❌ Often flagged due to data flow tracking
    }

}

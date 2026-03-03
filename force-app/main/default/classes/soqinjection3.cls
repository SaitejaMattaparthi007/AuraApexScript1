// Intentionally vulnerable Apex for deep DataFlow tracing
// Rule: sf:SOQLInjection
// DO NOT USE IN PRODUCTION

public with sharing class Sonar_SOQLInjection_DeepTrace {

    /*
     ==========================================================
     SCENARIO 1:
     Multiple reassignments (6 times) with final unsafe usage
     ==========================================================
    */
    public static List<Account> multipleReassignments(String userInput) {

        String filter = userInput;                         // 1 - source
        filter = filter.trim();                            // 2
        filter = filter + '';                              // 3
        filter = String.escapeSingleQuotes(filter);        // 4 (sanitized)
        filter = filter.replace('test','demo');            // 5
        filter = userInput;                                // 6 ❌ overwritten with raw input

        String query = 'SELECT Id FROM Account WHERE Name = \'' + filter + '\'';
        return Database.query(query); // ❌ Expected violation
    }


    /*
     ==========================================================
     SCENARIO 2:
     Sanitized then reassigned multiple times
     ==========================================================
    */
    public static List<Contact> sanitizedThenCorrupted(String input) {

        String value = String.escapeSingleQuotes(input);   // 1 sanitized
        value = value.toLowerCase();                       // 2
        value = value + '';                                // 3
        value = value.trim();                              // 4
        value = value + ' ';                               // 5
        value = input;                                     // 6 ❌ raw input reintroduced

        String query = 'SELECT Id FROM Contact WHERE Email = \'' + value + '\'';
        return Database.query(query); // ❌ Violation
    }


    /*
     ==========================================================
     SCENARIO 3:
     Assignment inside loop with random branching
     ==========================================================
    */
    public static List<Account> loopAssignment(List<String> inputs) {

        String filter;

        for (String s : inputs) {

            if (Math.mod(Crypto.getRandomInteger(), 2) == 0) {
                filter = String.escapeSingleQuotes(s);
            } else {
                filter = s; // ❌ unsanitized path
            }

            filter = filter.trim();  // extra mutation
        }

        String query = 'SELECT Id FROM Account WHERE Name = \'' + filter + '\'';
        return Database.query(query); // ❌ Likely violation
    }


    /*
     ==========================================================
     SCENARIO 4:
     Nested method propagation
     ==========================================================
    */
    public static List<Account> nestedPropagation(String userInput) {
        String processed = firstLayer(userInput);
        String query = 'SELECT Id FROM Account WHERE Name = \'' + processed + '\'';
        return Database.query(query); // ❌ Violation
    }

    private static String firstLayer(String val) {
        val = secondLayer(val);
        val = val.trim();
        return val;
    }

    private static String secondLayer(String v) {
        v = v.toUpperCase();
        return v; // ❌ never sanitized
    }


    /*
     ==========================================================
     SCENARIO 5:
     Partial sanitization but object injection
     ==========================================================
    */
    public static List<SObject> objectInjection(String objectName, String fieldName) {

        fieldName = String.escapeSingleQuotes(fieldName); // sanitized field only

        String query = 'SELECT ' + fieldName + ' FROM ' + objectName;
        return Database.query(query); // ❌ objectName unsafe
    }


    /*
     ==========================================================
     SCENARIO 6:
     Reassignment chain inside conditional branches
     ==========================================================
    */
    public static List<Account> complexBranching(String input, Boolean flag) {

        String val = input;                      // 1
        val = val.trim();                        // 2

        if (flag) {
            val = String.escapeSingleQuotes(val); // 3
            val = val.toLowerCase();              // 4
        } else {
            val = val.toUpperCase();              // 5
            val = input;                          // 6 ❌ raw again
        }

        val = val + '';                           // 7

        String query = 'SELECT Id FROM Account WHERE Name = \'' + val + '\'';
        return Database.query(query); // ❌ Violation
    }


    /*
     ==========================================================
     SCENARIO 7:
     ORDER BY injection with reassignment chain
     ==========================================================
    */
    public static List<Account> orderByInjection(String sortField) {

        String order = sortField;         // 1
        order = order.trim();             // 2
        order = order.toLowerCase();      // 3
        order = order + '';               // 4
        order = sortField;                // 5 ❌ revert

        String query = 'SELECT Id, Name FROM Account ORDER BY ' + order;
        return Database.query(query); // ❌ Violation
    }


    /*
     ==========================================================
     SCENARIO 8:
     LIMIT injection with numeric confusion
     ==========================================================
    */
    public static List<Account> limitInjection(String limitValue) {

        String limit = limitValue;            // 1
        limit = limit.trim();                 // 2
        limit = limit + '';                   // 3
        limit = limit.replace(' ', '');       // 4
        limit = limitValue;                   // 5 ❌ raw input reintroduced

        String query = 'SELECT Id FROM Account LIMIT ' + limit;
        return Database.query(query); // ❌ Violation
    }

}

// Intentionally vulnerable / bad-quality Apex for SonarQube testing.
// DO NOT DEPLOY TO PRODUCTION.
public with sharing class SonarQubeIssuesDemo {

    // -------------------------
    // Security: SOQL Injection (Security Hotspot / Vulnerability)
    // -------------------------
    public static List<Account> findAccounts_SoqlInjection(String userInput) {
        // ❌ User input concatenated into SOQL
        String q = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + userInput + '%\'';
        return Database.query(q);
    }

    // -------------------------
    // Performance: DML inside a loop (Code smell / Bug risk)
    // -------------------------
    public static void createContacts_DmlInLoop(List<String> names) {
        for (String n : names) {
            // ❌ DML in loop
            insert new Contact(LastName = n);
        }
    }

    // -------------------------
    // Performance: SOQL inside a loop (Code smell / Bug risk)
    // -------------------------
    public static Integer countContactsPerAccount_SoqlInLoop(List<Id> accountIds) {
        Integer total = 0;
        for (Id accId : accountIds) {
            // ❌ SOQL in loop
            total += [SELECT COUNT() FROM Contact WHERE AccountId = :accId];
        }
        return total;
    }

    // -------------------------
    // Reliability: Empty catch block (Code smell)
    // -------------------------
    public static void emptyCatchBlock() {
        try {
            Integer x = 1 / 0;
        } catch (Exception e) {
            // ❌ Swallowing exception
        }
    }

    // -------------------------
    // Reliability/Maintainability: Catching generic Exception + weak logging
    // -------------------------
    public static void genericCatchWeakLogging(String s) {
        try {
            Integer.valueOf(s);
        } catch (Exception e) { // ❌ too generic
            System.debug('error'); // ❌ not actionable
        }
    }

    // -------------------------
    // Security Hotspot: Hardcoded secret-like token
    // -------------------------
    public static String getHardcodedApiKey() {
        // ❌ Hardcoded secret / credential pattern
        return 'AKIA_THIS_LOOKS_LIKE_A_SECRET';
    }

    // -------------------------
    // Security Hotspot: Missing CRUD/FLS checks before DML
    // (Depending on your Quality Profile, this may be flagged)
    // -------------------------
    public static void updateAccounts_NoCrudFls(List<Account> accs) {
        // ❌ No Schema checks
        update accs;
    }

    // -------------------------
    // Maintainability: High cyclomatic complexity / deep nesting
    // -------------------------
    public static String highComplexity(Integer a, Integer b, Integer c) {
        if (a != null) {
            if (b != null) {
                if (c != null) {
                    if (a > 10) {
                        if (b > 10) {
                            if (c > 10) {
                                return 'ALL_BIG';
                            } else {
                                return 'C_SMALL';
                            }
                        } else {
                            return 'B_SMALL';
                        }
                    } else {
                        return 'A_SMALL';
                    }
                }
            }
        }
        return 'UNKNOWN';
    }

    // -------------------------
    // Code Smell: Unused variable + dead code
    // -------------------------
    public static void unusedAndDeadCode() {
        Integer unused = 123; // ❌ unused
        if (false) {
            System.debug('dead'); // ❌ dead code
        }
    }

    // -------------------------
    // Performance: String concatenation in a loop
    // -------------------------
    public static String stringConcatInLoop(List<String> names) {
        String out = '';
        for (String n : names) {
            // ❌ inefficient concatenation
            out += n + ',';
        }
        return out;
    }

    // ============================================================
    // EXTRA SECURITY HOTSPOTS (intentionally risky patterns)
    // ============================================================

    // -------------------------
    // Security Hotspot: Dynamic Apex execution (if your ruleset flags it)
    // -------------------------
    public static Object dynamicApexExecution_Hotspot(String typeName) {
        // ❌ Reflective/dynamic type usage can be flagged as hotspot
        // (May be blocked/limited depending on org settings, but used here for static analysis testing.)
        Type t = Type.forName(typeName);
        if (t == null) {
            return null;
        }
        return t.newInstance();
    }

    // -------------------------
    // Security Hotspot: HTTP callout without strict allowlist / weak validation
    // -------------------------
    public static String insecureHttpCallout_Hotspot(String urlFromUser) {
        // ❌ URL is taken from user input; no allowlist / validation
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(urlFromUser);

        Http http = new Http();
        HttpResponse res = http.send(req);
        return res.getBody();
    }

    // -------------------------
    // Security: Potential XSS in Visualforce context (Hotspot / Smell)
    // Note: This is a simplistic pattern; Sonar may flag unescaped output patterns.
    // -------------------------
    public static String reflectUserInput_PotentialXss(String input) {
        // ❌ returning raw user-controlled input that might get rendered later
        return input;
    }

    // -------------------------
    // Security Hotspot: Excessive debug logging of sensitive data
    // -------------------------
    public static void logSensitiveData_Hotspot(String passwordOrToken) {
        // ❌ Logging secrets
        System.debug('User secret: ' + passwordOrToken);
    }
}

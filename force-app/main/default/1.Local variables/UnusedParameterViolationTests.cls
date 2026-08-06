/**
 * This class contains test cases specifically designed to trigger the 
 * 'sf:UnusedFormalParameter' rule in CodeScan/SonarQube.
 * 
 * To trigger the violation, a parameter must be defined in the method signature 
 * but NOT used anywhere in the method body (including dynamic SOQL strings).
 */
public class UnusedParameterViolationTests {

    /**
     * SCENARIO 1: Basic Unused Parameter
     * VIOLATION: 'unusedParam' is defined but never referenced.
     */
    public void triggerBasicViolation(String usedParam, String unusedParam) {
        String query = 'SELECT Id FROM Account WHERE Name = :usedParam';
        Database.query(query);
    }

    /**
     * SCENARIO 2: Unused Parameter in Concatenation
     * VIOLATION: 'p3' is defined but omitted from the final concatenated string.
     */
    public void triggerConcatenationViolation(String p1, String p2, String p3) {
        String cond = 'Name = :p1';
        cond += ' AND Status = :p2';
        Database.query('SELECT Id FROM Contact WHERE ' + cond);
    }

    /**
     * SCENARIO 3: Variable Re-assignment Overwriting Usage
     * VIOLATION: 'p1' was in the first string, but the variable is overwritten 
     * with a string that only uses 'p2'. 'p1' is now effectively unused.
     */
    public void triggerReassignmentViolation(String p1, String p2) {
        String soql = 'Name = :p1';
        soql = 'Name = :p2'; 
        Database.query('SELECT Id FROM Lead WHERE ' + soql);
    }

    /**
     * SCENARIO 4: Multiple Unused Parameters
     * VIOLATION: Both 'unused1' and 'unused2' should be flagged.
     */
    public void triggerMultipleViolations(Integer unused1, String used, Boolean unused2) {
        System.debug('Using only: ' + used);
    }

    /**
     * SCENARIO 5: Dynamic SOQL Entry Points (getQueryLocator)
     * VIOLATION: 'p2' is not used in the QueryLocator string.
     */
    public void triggerQueryLocatorViolation(String p1, String p2) {
        String queryStr = 'SELECT Id FROM Opportunity WHERE StageName = :p1';
        Database.getQueryLocator(queryStr);
    }

    /**
     * SCENARIO 6: Custom Method Sink (e.g., QueryBuilder)
     * VIOLATION: 'p2' is not used in the condition string passed to the method.
     */
    public void triggerCustomSinkViolation(String p1, String p2) {
        String cond = 'Amount > :p1';
        // Assuming a custom class exists for testing
        MockQueryBuilder qb = new MockQueryBuilder();
        qb.setCondition(cond);
    }

    // Mock class to support Scenario 6
    private class MockQueryBuilder {
        public void setCondition(String c) {
            System.debug(c);
        }
    }
}

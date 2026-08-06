/**
 * Sophos Ticket: Unused formal parameter rule
 * This class contains unit test scenarios for dynamic SOQL variable resolution.
 */
public class SophosUnusedParameterTests {

    // 1. LOCAL VARIABLE RESOLUTION SCENARIOS

    /**
     * Scenario: Basic Variable Assignment
     * Expected: No issue for 'name'.
     */
    public void basicVariableUsage(String name) {
        String cond = 'Name = :name';
        // Simulating a dynamic SOQL sink
        Database.query('SELECT Id FROM Account WHERE ' + cond);
    }

    /**
     * Scenario: Unused Parameter with Variable
     * Expected: 'p2' flagged as unused because it's missing from queryStr.
     */
    public void partialUsage(String p1, String p2) {
        String queryStr = 'SELECT Id FROM Account WHERE Field1 = :p1';
        Database.query(queryStr); 
    }

    /**
     * Scenario: Complex/Concatenated Variables
     * Expected: Both 'p1' and 'p2' resolved as used.
     */
    public void concatenatedUsage(String p1, String p2) {
        String c = 'Status = :p1';
        c += ' AND Type = :p2';
        Database.query('SELECT Id FROM Case WHERE ' + c);
    }

    /**
     * Scenario: Variable Re-assignment
     * Expected: 'p1' flagged as unused; 'p2' resolved as used.
     */
    public void reassignmentTest(String p1, String p2) {
        String cond = 'Name = :p1';
        cond = 'Name = :p2'; 
        Database.query('SELECT Id FROM Contact WHERE ' + cond);
    }


    // 2. REGRESSION & DIRECT LITERAL SCENARIOS

    /**
     * Scenario: Direct String Literals
     * Expected: No issue for 'name'.
     */
    public void directLiteral(String name) {
        Database.query('SELECT Id FROM Contact WHERE Name = :name');
    }

    /**
     * Scenario: False Positive Prevention
     * Expected: No issues flagged as p1 is used in both paths.
     */
    public void falsePositivePrevention(String p1, Boolean check) {
        String q = 'SELECT Id FROM Account';
        if(check) {
            q += ' WHERE Name = :p1';
        } else {
            q += ' WHERE Description = :p1';
        }
        Database.query(q);
    }

    /**
     * Scenario: Supported API Coverage
     * Expected: All parameters (p1, p2, p3) resolved as used.
     */
    public void apiCoverage(String p1, String p2, String p3) {
        // Database.query
        Database.query('SELECT Id FROM Lead WHERE Email = :p1');
        
        // Database.getQueryLocator
        Database.getQueryLocator('SELECT Id FROM Task WHERE Subject = :p2');
        
        // Custom/Standard setCondition (Simulated)
        QueryBuilder qb = new QueryBuilder();
        qb.setCondition('Phone = :p3');
    }

    // Mock class to support setCondition scenario
    public class QueryBuilder {
        public void setCondition(String cond) {
            System.debug('Condition set: ' + cond);
        }
    }
}

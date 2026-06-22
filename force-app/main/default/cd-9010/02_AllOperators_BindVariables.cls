/**
 * FILE: 02_AllOperators_BindVariables.cls
 * RULE: sf:UnusedFormalParameter
 * TICKET: CD-9010
 * PURPOSE: Test bind variable detection across ALL SOQL operators
 *          (=, !=, >, <, >=, <=, IN) inside dynamic query strings.
 *
 * EXPECTED: Rule should NOT fire on any parameter — all are bind variables.
 * CURRENT BUG: Rule only detects IN :var pattern, misses all others.
 */
public class AllOperatorsBindVariables {

    // OPERATOR: = (Equals)
    // FALSE POSITIVE expected on 'targetStatus'
    public List<Case> getCasesByStatus(String targetStatus) {
        String query = 'SELECT Id, Subject, Status FROM Case WHERE Status = :targetStatus';
        return (List<Case>) Database.query(query);
    }

    // OPERATOR: != (Not Equals)
    // FALSE POSITIVE expected on 'excludedStatus'
    public List<Case> getCasesExcludingStatus(String excludedStatus) {
        String query = 'SELECT Id, Subject, Status FROM Case WHERE Status != :excludedStatus';
        return (List<Case>) Database.query(query);
    }

    // OPERATOR: > (Greater Than)
    // FALSE POSITIVE expected on 'minAmount'
    public List<Opportunity> getOppsAboveAmount(Decimal minAmount) {
        String query = 'SELECT Id, Name, Amount FROM Opportunity WHERE Amount > :minAmount';
        return (List<Opportunity>) Database.query(query);
    }

    // OPERATOR: < (Less Than)
    // FALSE POSITIVE expected on 'maxAmount'
    public List<Opportunity> getOppsBelowAmount(Decimal maxAmount) {
        String query = 'SELECT Id, Name, Amount FROM Opportunity WHERE Amount < :maxAmount';
        return (List<Opportunity>) Database.query(query);
    }

    // OPERATOR: >= (Greater Than or Equal)
    // FALSE POSITIVE expected on 'startDate'
    public List<Task> getTasksAfterDate(Date startDate) {
        String query = 'SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate >= :startDate';
        return (List<Task>) Database.query(query);
    }

    // OPERATOR: <= (Less Than or Equal)
    // FALSE POSITIVE expected on 'endDate'
    public List<Task> getTasksBeforeDate(Date endDate) {
        String query = 'SELECT Id, Subject, ActivityDate FROM Task WHERE ActivityDate <= :endDate';
        return (List<Task>) Database.query(query);
    }

    // OPERATOR: IN (existing support — should already work)
    // NO false positive expected — this pattern is already detected
    public List<Account> getAccountsByIds(Set<Id> accountIds) {
        String query = 'SELECT Id, Name FROM Account WHERE Id IN :accountIds';
        return (List<Account>) Database.query(query);
    }

    // OPERATOR: NOT IN
    // FALSE POSITIVE expected on 'excludedIds'
    public List<Account> getAccountsExcludingIds(Set<Id> excludedIds) {
        String query = 'SELECT Id, Name FROM Account WHERE Id NOT IN :excludedIds';
        return (List<Account>) Database.query(query);
    }

    // OPERATOR: LIKE
    // FALSE POSITIVE expected on 'searchPattern'
    public List<Lead> searchLeadsByName(String searchPattern) {
        String query = 'SELECT Id, Name FROM Lead WHERE Name LIKE :searchPattern';
        return (List<Lead>) Database.query(query);
    }

    // MULTIPLE OPERATORS in single query
    // FALSE POSITIVE expected on 'statusVal', 'minAmt', 'cutoffDate'
    public List<Opportunity> getFilteredOpps(String statusVal, Decimal minAmt, Date cutoffDate) {
        String query = 'SELECT Id, Name, Amount, StageName, CloseDate FROM Opportunity '
            + 'WHERE StageName = :statusVal AND Amount >= :minAmt AND CloseDate <= :cutoffDate';
        return (List<Opportunity>) Database.query(query);
    }
}

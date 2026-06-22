/**
 * FILE: 04_DatabaseQuery_DirectBindVariables.cls
 * RULE: sf:UnusedFormalParameter
 * TICKET: CD-9010
 * PURPOSE: Direct Database.query() with bind variables in string-built SOQL
 *          (no FF Lib). Tests bind detection outside QueryFactory context.
 *
 * EXPECTED: Rule should NOT fire — params are bind variables in dynamic SOQL.
 */
public class DatabaseQueryDirectBindVariables {

    // Direct Database.query with = bind variable
    public List<User> findUserByUsername(String username) {
        String soql = 'SELECT Id, Username, Email FROM User WHERE Username = :username';
        return (List<User>) Database.query(soql);
    }

    // Direct Database.query with multiple bind variables
    public List<Account> findAccounts(String accName, String accType, Date createdAfter) {
        String soql = 'SELECT Id, Name, Type, CreatedDate FROM Account '
            + 'WHERE Name = :accName AND Type = :accType AND CreatedDate > :createdAfter';
        return (List<Account>) Database.query(soql);
    }

    // Dynamic SOQL built with conditional logic
    public List<Opportunity> searchOpportunities(String stage, Decimal minAmt, Boolean includeAmount) {
        String soql = 'SELECT Id, Name, StageName, Amount FROM Opportunity WHERE StageName = :stage';
        if (includeAmount) {
            soql += ' AND Amount >= :minAmt';
        }
        return (List<Opportunity>) Database.query(soql);
    }

    // Database.query with bind variable in a method-local string variable
    public List<Contact> getContactsByDepartment(String departmentName) {
        String whereClause = 'Department = :departmentName';
        String soql = 'SELECT Id, Name, Department FROM Contact WHERE ' + whereClause;
        return (List<Contact>) Database.query(soql);
    }

    // Database.query with Date/DateTime bind variables
    public List<Event> getEventsBetweenDates(DateTime startDt, DateTime endDt) {
        String soql = 'SELECT Id, Subject, StartDateTime, EndDateTime FROM Event '
            + 'WHERE StartDateTime >= :startDt AND EndDateTime <= :endDt';
        return (List<Event>) Database.query(soql);
    }

    // Database.queryWithBinds pattern (alternative)
    public List<Account> queryWithBindMap(String accountName) {
        String soql = 'SELECT Id, Name FROM Account WHERE Name = :accountName';
        Map<String, Object> bindVars = new Map<String, Object>{
            'accountName' => accountName
        };
        return (List<Account>) Database.queryWithBinds(soql, bindVars, AccessLevel.USER_MODE);
    }
}

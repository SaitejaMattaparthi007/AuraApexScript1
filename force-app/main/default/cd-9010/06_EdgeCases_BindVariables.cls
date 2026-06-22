/**
 * FILE: 06_EdgeCases_BindVariables.cls
 * RULE: sf:UnusedFormalParameter
 * TICKET: CD-9010
 * PURPOSE: Edge cases for bind variable detection — unusual but valid patterns.
 *
 * EXPECTED: Rule should NOT fire on any parameter — all are bind variables.
 */
public class EdgeCasesBindVariables {

    // EDGE CASE: Bind variable in SOQL string assigned to a class-level variable
    private String cachedQuery;
    public List<Account> getCachedAccounts(String accName) {
        cachedQuery = 'SELECT Id, Name FROM Account WHERE Name = :accName';
        return (List<Account>) Database.query(cachedQuery);
    }

    // EDGE CASE: Bind variable used in a ternary-built condition
    public List<Contact> getContactsDynamic(String lastName, Boolean filterByEmail, String emailVal) {
        String condition = 'LastName = :lastName';
        condition += filterByEmail ? ' AND Email = :emailVal' : '';
        String soql = 'SELECT Id, Name, Email FROM Contact WHERE ' + condition;
        return (List<Contact>) Database.query(soql);
    }

    // EDGE CASE: Parameter name matches a field name (potential confusion)
    public List<Account> getByName(String Name) {
        String soql = 'SELECT Id, Name FROM Account WHERE Name = :Name';
        return (List<Account>) Database.query(soql);
    }

    // EDGE CASE: Bind variable inside a SOSL query
    public List<List<SObject>> searchRecords(String searchTerm) {
        String sosl = 'FIND :searchTerm IN ALL FIELDS RETURNING Account(Id, Name), Contact(Id, Name)';
        return Search.query(sosl);
    }

    // EDGE CASE: Bind variable used in Database.countQuery
    public Integer countRecords(String status) {
        String soql = 'SELECT COUNT() FROM Case WHERE Status = :status';
        return Database.countQuery(soql);
    }

    // EDGE CASE: Bind variable inside a for-loop SOQL (string-based)
    public void processAccounts(String industry) {
        String soql = 'SELECT Id, Name FROM Account WHERE Industry = :industry';
        for (Account acc : (List<Account>) Database.query(soql)) {
            System.debug(acc.Name);
        }
    }

    // EDGE CASE: Bind variable in SOQL with subquery
    public List<Account> getAccountsWithContacts(String accType, String contactTitle) {
        String soql = 'SELECT Id, Name, '
            + '(SELECT Id, Name FROM Contacts WHERE Title = :contactTitle) '
            + 'FROM Account WHERE Type = :accType';
        return (List<Account>) Database.query(soql);
    }

    // EDGE CASE: Same parameter used in two different queries
    public List<SObject> getDualResults(String nameFilter) {
        List<Account> accounts = (List<Account>) Database.query(
            'SELECT Id, Name FROM Account WHERE Name = :nameFilter'
        );
        List<Contact> contacts = (List<Contact>) Database.query(
            'SELECT Id, Name FROM Contact WHERE LastName = :nameFilter'
        );
        List<SObject> results = new List<SObject>();
        results.addAll(accounts);
        results.addAll(contacts);
        return results;
    }
}

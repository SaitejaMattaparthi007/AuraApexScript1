/**
 * FILE: 07_CustomerExactPattern.cls
 * RULE: sf:UnusedFormalParameter
 * TICKET: CD-9010 (Support Ticket #231704)
 * PURPOSE: EXACT reproduction of the customer's reported pattern.
 *          Uses fflib_QueryFactory with newQueryFactory() and
 *          parameters consumed as SOQL bind variables in setCondition().
 *
 * EXPECTED: Rule should NOT fire on 'username' or 'abcd'.
 * CURRENT BUG: Rule flags both as "unused formal parameters".
 */
public class CustomerExactPattern extends fflib_SObjectDomain {

    // EXACT CUSTOMER PATTERN from ticket description
    public List<User> getUserByUsername(String username, DateTime abcd) {
        String query = newQueryFactory()
            .setCondition('Username = :username AND CreatedDate > :abcd')
            .toSOQL();
        return (List<User>) Database.query(query);
    }

    // VARIATION: Same pattern with different SObject
    public List<Account> getAccountByType(String accountType, Date createdAfter) {
        String soql = newQueryFactory()
            .setCondition('Type = :accountType AND CreatedDate >= :createdAfter')
            .toSOQL();
        return (List<Account>) Database.query(soql);
    }

    // VARIATION: Multiple chained conditions
    public List<Contact> findContacts(String firstName, String lastName, String email) {
        String soql = newQueryFactory()
            .setCondition('FirstName = :firstName AND LastName = :lastName AND Email = :email')
            .toSOQL();
        return (List<Contact>) Database.query(soql);
    }

    // VARIATION: QueryFactory with selectField + setCondition + setOrdering
    public List<Opportunity> getRecentDeals(String stageName, Decimal minAmount) {
        String soql = newQueryFactory()
            .selectField('Id')
            .selectField('Name')
            .selectField('Amount')
            .selectField('StageName')
            .selectField('CloseDate')
            .setCondition('StageName = :stageName AND Amount >= :minAmount')
            .toSOQL();
        return (List<Opportunity>) Database.query(soql);
    }

    // VARIATION: With LIMIT and inequality operators
    public List<Lead> getRecentLeads(DateTime cutoffDate, String leadSource) {
        String soql = newQueryFactory()
            .setCondition('CreatedDate > :cutoffDate AND LeadSource != :leadSource')
            .setLimit(200)
            .toSOQL();
        return (List<Lead>) Database.query(soql);
    }

    // Constructor (required for fflib_SObjectDomain)
    public CustomerExactPattern(List<SObject> records) {
        super(records);
    }
}

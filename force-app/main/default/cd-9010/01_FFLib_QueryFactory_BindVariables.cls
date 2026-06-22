/**
 * FILE: 01_FFLib_QueryFactory_BindVariables.cls
 * RULE: sf:UnusedFormalParameter
 * TICKET: CD-9010
 * PURPOSE: Reproduce FALSE POSITIVE - Parameters used as SOQL bind variables
 *          inside FF Lib QueryFactory dynamic query strings.
 *
 * EXPECTED: Rule should NOT fire on 'username' and 'abcd' — they are used
 *           as bind variables resolved at runtime by Salesforce.
 * CURRENT BUG: Rule flags them as "unused" because bind-detection only
 *              covers the IN :var form, not string-based :var patterns.
 */
public class FFLibQueryFactoryBindVariables {

    // FALSE POSITIVE: 'username' and 'abcd' are bind variables inside SOQL string
    public List<User> getUsersByUsername(String username, DateTime abcd) {
        String query = new fflib_QueryFactory(User.SObjectType)
            .setCondition('Username = :username AND CreatedDate > :abcd')
            .toSOQL();
        return (List<User>) Database.query(query);
    }

    // FALSE POSITIVE: 'accountName' used as bind variable in QueryFactory
    public List<Account> getAccountsByName(String accountName) {
        String soql = new fflib_QueryFactory(Account.SObjectType)
            .selectField('Id')
            .selectField('Name')
            .setCondition('Name = :accountName')
            .toSOQL();
        return (List<Account>) Database.query(soql);
    }

    // FALSE POSITIVE: 'minAmount' used as bind variable with > operator
    public List<Opportunity> getOpportunitiesAboveAmount(Decimal minAmount) {
        fflib_QueryFactory qf = new fflib_QueryFactory(Opportunity.SObjectType);
        qf.selectField('Id');
        qf.selectField('Amount');
        qf.setCondition('Amount > :minAmount');
        return (List<Opportunity>) Database.query(qf.toSOQL());
    }

    // FALSE POSITIVE: Multiple params used as bind variables in chained condition
    public List<Contact> searchContacts(String lastName, String email, Date startDate) {
        String query = new fflib_QueryFactory(Contact.SObjectType)
            .selectField('Id')
            .selectField('LastName')
            .selectField('Email')
            .setCondition('LastName = :lastName AND Email = :email AND CreatedDate >= :startDate')
            .toSOQL();
        return (List<Contact>) Database.query(query);
    }
}

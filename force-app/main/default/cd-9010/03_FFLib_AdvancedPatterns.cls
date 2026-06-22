/**
 * FILE: 03_FFLib_AdvancedPatterns.cls
 * RULE: sf:UnusedFormalParameter
 * TICKET: CD-9010
 * PURPOSE: Advanced FF Lib patterns — chained QueryFactory, sub-selects,
 *          multi-level conditions with bind variables.
 *
 * EXPECTED: Rule should NOT fire — all params used as bind variables.
 */
public class FFLibAdvancedPatterns {

    // PATTERN: QueryFactory with ordering and limit + bind variable
    public List<Account> getTopAccountsByRevenue(Decimal revenueThreshold) {
        fflib_QueryFactory qf = new fflib_QueryFactory(Account.SObjectType);
        qf.selectField('Id');
        qf.selectField('Name');
        qf.selectField('AnnualRevenue');
        qf.setCondition('AnnualRevenue >= :revenueThreshold');
        qf.setOrdering('AnnualRevenue', fflib_QueryFactory.SortOrder.DESCENDING);
        qf.setLimit(100);
        return (List<Account>) Database.query(qf.toSOQL());
    }

    // PATTERN: Nested condition string with AND/OR and multiple bind vars
    public List<Contact> getFilteredContacts(String dept, String title, Date hireDate) {
        String query = new fflib_QueryFactory(Contact.SObjectType)
            .selectField('Id')
            .selectField('Name')
            .selectField('Department')
            .selectField('Title')
            .setCondition('(Department = :dept AND Title = :title) OR CreatedDate >= :hireDate')
            .toSOQL();
        return (List<Contact>) Database.query(query);
    }

    // PATTERN: Variable assigned from QueryFactory, then passed to Database.query
    public List<Lead> getLeadsBySource(String leadSource, String rating) {
        fflib_QueryFactory factory = new fflib_QueryFactory(Lead.SObjectType);
        factory.selectField('Id');
        factory.selectField('Name');
        factory.selectField('LeadSource');
        factory.selectField('Rating');
        factory.setCondition('LeadSource = :leadSource AND Rating != :rating');
        String generatedSOQL = factory.toSOQL();
        return (List<Lead>) Database.query(generatedSOQL);
    }

    // PATTERN: QueryFactory built in helper method, bind vars from caller scope
    public List<Opportunity> findDeals(String stageName, Decimal minAmount) {
        String soql = buildOpportunityQuery(stageName, minAmount);
        return (List<Opportunity>) Database.query(soql);
    }

    private String buildOpportunityQuery(String stageName, Decimal minAmount) {
        return new fflib_QueryFactory(Opportunity.SObjectType)
            .selectField('Id')
            .selectField('Name')
            .selectField('Amount')
            .selectField('StageName')
            .setCondition('StageName = :stageName AND Amount > :minAmount')
            .toSOQL();
    }

    // PATTERN: QueryFactory with IN operator (should already work, regression test)
    public List<Case> getCasesByTypes(Set<String> caseTypes) {
        String query = new fflib_QueryFactory(Case.SObjectType)
            .selectField('Id')
            .selectField('Subject')
            .selectField('Type')
            .setCondition('Type IN :caseTypes')
            .toSOQL();
        return (List<Case>) Database.query(query);
    }

    // PATTERN: Condition string built via concatenation with bind variable
    public List<Account> getAccountsByIndustry(String industryVal, Integer employeeCount) {
        String condition = 'Industry = :industryVal';
        condition += ' AND NumberOfEmployees > :employeeCount';
        String query = new fflib_QueryFactory(Account.SObjectType)
            .selectField('Id')
            .selectField('Name')
            .setCondition(condition)
            .toSOQL();
        return (List<Account>) Database.query(query);
    }
}

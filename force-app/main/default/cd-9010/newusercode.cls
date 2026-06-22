public with sharing class UnusedFormalParameterTestData {

    // No violation - "=" operator
    public void testEquals(String username) {
        String soql = new QueryFactory()
            .setCondition('Username = :username')
            .toSOQL();

        Database.query(soql);
    }

    // No violation - "!=" operator
    public void testNotEquals(String username) {
        String soql = new QueryFactory()
            .setCondition('Username != :username')
            .toSOQL();

        Database.query(soql);
    }

    // No violation - ">" operator
    public void testGreaterThan(Datetime createdAfter) {
        String soql = new QueryFactory()
            .setCondition('CreatedDate > :createdAfter')
            .toSOQL();

        Database.query(soql);
    }

    // No violation - "<" operator
    public void testLessThan(Datetime createdBefore) {
        String soql = new QueryFactory()
            .setCondition('CreatedDate < :createdBefore')
            .toSOQL();

        Database.query(soql);
    }

    // No violation - ">=" operator
    public void testGreaterThanOrEqual(Datetime startDate) {
        String soql = new QueryFactory()
            .setCondition('CreatedDate >= :startDate')
            .toSOQL();

        Database.query(soql);
    }

    // No violation - "<=" operator
    public void testLessThanOrEqual(Datetime endDate) {
        String soql = new QueryFactory()
            .setCondition('CreatedDate <= :endDate')
            .toSOQL();

        Database.query(soql);
    }

    // No violation - existing IN support
    public void testInOperator(Set<String> usernames) {
        String soql = new QueryFactory()
            .setCondition('Username IN :usernames')
            .toSOQL();

        Database.query(soql);
    }

    // No violation - multiple bind variables
    public void testMultipleBinds(String username, Datetime createdAfter) {
        String soql = new QueryFactory()
            .setCondition('Username = :username AND CreatedDate > :createdAfter')
            .toSOQL();

        Database.query(soql);
    }

    // Violation expected - parameter genuinely unused
    public void testUnusedParameter(String username) {
        String soql = 'SELECT Id FROM User';
        Database.query(soql);
    }

    // Violation expected - one used, one unused
    public void testPartiallyUsedParameter(String username, String email) {
        String soql = new QueryFactory()
            .setCondition('Username = :username')
            .toSOQL();

        Database.query(soql);
    }

    // Violation expected - parameter name appears as plain text, not bind variable
    public void testLiteralString(String username) {
        String soql = new QueryFactory()
            .setCondition('Username = \'username\'')
            .toSOQL();

        Database.query(soql);
    }

    // Violation expected - local variable used instead of method parameter
    public void testLocalVariableBind(String username) {
        String localVar = 'test';

        String soql = new QueryFactory()
            .setCondition('Username = :localVar')
            .toSOQL();

        Database.query(soql);
    }
}

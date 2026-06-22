/**
 * FILE: 05_NegativeTests_GenuinelyUnused.cls
 * RULE: sf:UnusedFormalParameter
 * TICKET: CD-9010
 * PURPOSE: NEGATIVE TESTS - Parameters that are GENUINELY unused.
 *          Rule SHOULD fire on these — confirms rule still catches real violations.
 *
 * EXPECTED: Rule fires on all parameters marked as "GENUINELY UNUSED".
 */
public class NegativeTestsGenuinelyUnused {

    // GENUINELY UNUSED: 'filterType' is declared but never referenced anywhere
    public List<Account> getAllAccounts(String filterType) {
        // filterType is completely unused — no SOQL bind, no logic, nothing
        return [SELECT Id, Name FROM Account LIMIT 100];
    }

    // GENUINELY UNUSED: 'maxResults' declared but hardcoded limit used instead
    public List<Contact> getContacts(Integer maxResults) {
        // maxResults is ignored — hardcoded LIMIT 50
        return [SELECT Id, Name FROM Contact LIMIT 50];
    }

    // GENUINELY UNUSED: 'sortField' declared but never used in query
    public List<Opportunity> getOpportunities(String sortField, String stage) {
        // 'sortField' is unused; 'stage' IS used in WHERE clause
        return [SELECT Id, Name, StageName FROM Opportunity WHERE StageName = :stage];
    }

    // GENUINELY UNUSED: 'debugMode' declared but never checked
    public List<Lead> getLeads(Boolean debugMode) {
        // debugMode is never referenced
        return [SELECT Id, Name FROM Lead WHERE IsConverted = false];
    }

    // MIXED: 'usedParam' is used, 'unusedParam' is not
    public List<Case> getMixedCase(String usedParam, String unusedParam) {
        // usedParam is used in SOQL, unusedParam is never referenced
        return [SELECT Id, Subject FROM Case WHERE Status = :usedParam];
    }
}

/**
 * Used to define methods to query User Object
 * Implements Object Selector Pattern for User object
 * Extends fflib_SobjectSelector
 */
public inherited sharing class UserSelector extends fflib_SObjectSelector {

    /**
     * Method to return User sObjectType
     * @return Schema.SObjectType of User
     */
    public Schema.SObjectType getSObjectType() {
        return User.sObjectType;
    }

    /**
     * Method to return fields of User
     * @return List of Schema.SObjectField of User to be queried
     */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            User.AccountId,
            User.Id,
            User.Name,
            User.FirstName,
            User.LastName,
            User.Email,
            user.Username,
            user.ProfileId,
            user.IsPortalEnabled,
            User.UserRoleId,
            User.IsActive,
            User.ManagerId,
            User.ContactId,
            User.EmployeeNumber,
            User.Legacy_ID__c,
            User.Phone,
            User.MobilePhone
        };
    }

    /**
     * Method to return a QueryLocator selecting User by LastName
     * @param accountIdSet to be used as a condition of the SOQL
     * @return List of the users
     */
    public List<User> selectPartnerUserByAccountID(Set<Id> accountIdSet) {
        String condition = 'IsActive = true and IsPortalEnabled = true and AccountId in :accountIdSet';
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition(condition);
        return (List<User>) Database.query(query.toSOQL());
    }

    /**
     * Method to return a single user, meant to be used to retrieve Test-created
     * user records to be used as running users.
     * @param username to be used as a condition of the SOQL
     * @return User record
     */
    @TestVisible
    private User selectByUsername(String username) {
        DateTime dateTimeOneHourAgo = System.Now().addHours(-1);
        return ((List<User>) Database.query(newQueryFactory()
                .setCondition('Username = :username AND CreatedDate > :dateTimeOneHourAgo')
                .addOrdering('CreatedDate', fflib_QueryFactory.SortOrder.DESCENDING)
                .setLimit(1)
                .toSOQL()))[0];
    }

    /**
     * Returns List<User> by selecting User by User Id Set
     * @param - List<Id> - list of user Ids
     * @return - List of User records
     */
    public List<User> selectByIds(Set<Id> userIdSet){
        fflib_QueryFactory queryFactory = newQueryFactory();
        queryFactory.selectField('Account.Partner_Type__c');
        queryFactory.selectField('Profile.Name');
        queryFactory.selectField('Account.CurrencyIsoCode');
        queryFactory.selectField('Account.l2a_Go_to_Market_Model__c');
        queryFactory.selectField('Account.BillingCountryCode');
        queryFactory.selectField('Account.l2a_Preferred_Distributor_Link__c');
        queryFactory.selectField('Account.l2a_Preferred_Distributor_Link__r.Name');
        queryFactory.selectField('Account.l2a_Preferred_Distributor_Status__c');
        queryFactory.setCondition('Id in :userIdSet');
        return (List<User>)Database.query(queryFactory.toSOQL());
    }

    /**
     * Returns List<User> by selecting User by Contact Id
     * @param - List<Id> - list of Contact Ids
     * @return - List of User records
     */
    public List<User> selectByContactIds(List<Id> contactIdList){
        fflib_QueryFactory queryFactory = newQueryFactory();
        queryFactory.setCondition('ContactId IN : contactIdList');
        return (List<User>)Database.query(queryFactory.toSOQL());
    }

    /**
    * Query matching user based on name and profile
    * @param userName - the name of user
    * @param profileName - the name of user's profile
    * @return List<User> list of matching user
    */
    public List<User> selectByNameAndProfileName(String userName, String profileName) {
        return (List<User>) Database.query(newQueryFactory().setCondition('Name = :userName AND Profile.Name = :profileName').toSOQL());
    }

    /**
    * Query matching user based on legacy ids
    * @param legacyIds - Set of legacy ids
    * @return Database.QueryLocator of the query
    */
    public Database.QueryLocator selectByLegacyIds(Set<String> legacyIds) {
        return Database.getQueryLocator(newQueryFactory().setCondition('Legacy_ID__c IN :legacyIds').toSOQL());
    }

    private class SelectorException extends Exception {}

    /**
     * Method to return active users based on Ids in userIds set
     * @param userIds - Set of User Ids
     * @return Database.QueryLocator of the query
     */
    public Database.QueryLocator selectActiveByIds(Set<Id> userIds) {
        return Database.getQueryLocator(newQueryFactory().setCondition('Id IN :userIds AND IsActive = TRUE').toSOQL());
    }

    /**
     * Method to return active internal (non-portal) users based on Ids in userIds set
     * @param userIds - Set of User Ids
     * @return Database.QueryLocator of the query
     */
    public Database.QueryLocator selectActiveInternalByIds(Set<Id> userIds) {
        return Database.getQueryLocator(newQueryFactory().setCondition('Id IN :userIds AND IsActive = TRUE AND UserType = \'Standard\'').toSOQL());
    }

    /**
    * Query matching user based on name for New deal registration approver user
    * @param listOfNames
    * @return List<User>
    */
    public List<User> selectByName(List<String> listOfNames) {
        return (List<User>)Database.query(newQueryFactory().setCondition('Name IN :listOfNames').toSOQL());
    }
    /**
     * Query matching user account details based on Id
     * @param userId - Id of the user
     * @return User
     */
    public User selectPartnerAccountDetailsById(String userId) {
        fflib_QueryFactory query = newQueryFactory();
        query.selectFields(new List<String>{
            'Id', 'Contact.FirstName', 'Contact.LastName', 'ContactId',
            'Account.pp_Account_Owner_Name__c', 'Account.pp_Account_Owner_Email__c',
            'Account.Partner_Level__c','Contact.l2a_Portal_Access_Type__c',
            'Account.l2a_Partner_Referral_ID__c','Account.Partner_Type__c',
            'Account.l2a_Preferred_Distributor_Link__r.Name',
            'Account.l2a_Preferred_Distributor_Link__c'
        });
        query.setCondition('Id = :userId');
        return ((List<User>)Database.query(query.toSOQL()))[0];
    }

    /**
     * Selects User with Account and Contact details for Portal Profile
     * @param userId - Id of the user
     * @return User with Account and Contact relationships populated
     */
    public User selectUserWithAccountAndContactForPortalProfile(String userId) {
        fflib_QueryFactory query = newQueryFactory();
        query.selectFields(getPortalProfileUserFields());
        query.selectFields(getPortalProfileContactFields());
        query.selectFields(getPortalProfileAccountFields());
        query.setCondition('Id = :userId');
        return ((List<User>)Database.query(query.toSOQL()))[0];
    }

    /**
     * Returns User fields required for Portal Profile
     * @return List of User field API names
     */
    private List<String> getPortalProfileUserFields() {
        return new List<String>{'Id', 'ContactId', 'AccountId'};
    }

    /**
     * Returns Contact fields required for Portal Profile
     * @return List of Contact field API names with relationship prefix
     */
    private List<String> getPortalProfileContactFields() {
        return new List<String>{
            'Contact.Id',
            'Contact.FirstName',
            'Contact.LastName',
            'Contact.Email',
            'Contact.Phone',
            'Contact.MobilePhone',
            'Contact.Fax',
            'Contact.MailingStreet',
            'Contact.MailingCity',
            'Contact.MailingState',
            'Contact.MailingStateCode',
            'Contact.MailingPostalCode',
            'Contact.MailingCountry',
            'Contact.MailingCountryCode',
            'Contact.l2a_Job_Title__c',
            'Contact.l2a_Role__c',
            'Contact.l2a_Portal_Access_Type__c',
            'Contact.l2a_Language__c',
            'Contact.l2a_Locale__c'
        };
    }

    /**
     * Returns Account fields required for Portal Profile
     * @return List of Account field API names with relationship prefix
     */
    private List<String> getPortalProfileAccountFields() {
        return new List<String>{
            'Account.Id', 'Account.Name', 'Account.Website', 'Account.Phone', 'Account.Fax',
            'Account.BillingStreet', 'Account.BillingCity', 'Account.BillingState', 'Account.BillingPostalCode',
            'Account.BillingCountry', 'Account.l2a_List_on_Website__c', 'Account.Partner_Type__c',
            'Account.l2a_Preferred_Distributor_Date__c', 'Account.l2a_Preferred_Distributor_Status__c',
            'Account.l2a_Preferred_Distributor_Link__c', 'Account.l2a_Preferred_Distributor_Link__r.Name',
            'Account.MSP_Partner_Status__c', 'Account.CSP_Partner_Status__c', 'Account.MSP_PSA_Vendor__c',
            'Account.MSP_RMM_Vendor__c', 'Account.Partner_App_Preferred_Distributor__c', 'Account.Partner_Level__c',
            'Account.Partner_T_s_and_C_s_Accepted_Date__c', 'Account.Partner_T_s_and_C_s_Accepted_By__c',
            'Account.MSP_T_s_and_C_s_Accepted_By__c', 'Account.MSP_T_s_and_C_s_Accepted_Date__c',
            'Account.l2a_EDI_Account_Number__c', 'Account.pp_Synchronized_Security_Accreditation__c',
            'Account.l2a_Sophos_Authorized_Training_Center__c', 'Account.l2a_MDF_Eligible__c',
            'Account.l2a_MSP_T_S_And_C_S_Version__c'
        };
	}
    /**
    * Find users based on all fields for a specific user type
    * @param searchTerm - the term to search for
    * @param userType - the type of user to find
    * @param recordLimit - the maximum number of records to return
    * @return List<User> - a list of users matching the search criteria
    */
    public List<User> findByAllFieldsBasedOnUserType(String searchTerm, String userType, Integer recordLimit) {
        String wildcardTerm = String.escapeSingleQuotes(searchTerm) + '*';

        List<List<SObject>> searchResults = [FIND :wildcardTerm IN Name FIELDS RETURNING User(Id, Name, UserRoleId, UserRole.Name
                                             WHERE UserType = :userType AND IsActive = true)
                                             LIMIT :recordLimit];
        return (List<User>) searchResults.get(0);
    }

    /**
    * Query recently viewed users based on user type
    * @param userType - the type of user to find
    * @param recordLimit - the maximum number of records to return
    * @return List<User> - a list of recently viewed users matching the search criteria
    */
    public List<User> selectRecentlyViewedUsersByUserType(String userType, Integer recordLimit) {
        String condition = 'UserType = :userType AND LastViewedDate != null';

        return Database.query(newQueryFactory().selectFields(new List<String>{'UserRoleId', 'UserRole.Name'}).setCondition(condition)
                              .addOrdering('LastViewedDate', fflib_QueryFactory.SortOrder.DESCENDING)
                              .setLimit(recordLimit).toSOQL());
    }

    /**
    * Query matching user based on email
    * @param email - Email of the user
    * @return List<User>
    */
    public List<User> selectCurrentApproverUserByEmail(String email) {
		return (List<User>) Database.query(newQueryFactory().selectFields(new List<String>{'Id', 'DelegatedApproverId', 'ManagerId'})
                                           .setCondition('Email = :email AND IsActive = true').toSOQL());
    }

    public List<User> selectByIdWithFields(Set<Id> userIdSet, List<String> fieldList){
        return Database.query(newQueryFactory(false)
            .selectFields(fieldList)
            .setCondition('Id IN :userIdSet').toSOQL());
    }
}
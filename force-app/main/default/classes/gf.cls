public with sharing class MetadataRuleUpdater {
    public static void updateSfExceptionRule() {
        // Create a custom metadata record
        Metadata.Metadata[] records = new Metadata.Metadata[] {};
        
        Metadata.CustomMetadata rule = new Metadata.CustomMetadata();
        rule.fullName = 'Custom_Rule.sf_exception';  // Adjust to match your metadata API name
        rule.label = 'sf:exception';
        rule.protected_x = false;

        // Add field values to update
        Metadata.CustomMetadataValue value1 = new Metadata.CustomMetadataValue();
        value1.field = 'ExceptionType__c';  // Example field
        value1.value = 'NullPointerException';
        
        rule.values.add(value1);
        records.add(rule);

        // Use system-level update
        Id jobId = Metadata.Operations.enqueueUpdate(records, Metadata.Operations.UPDATE_AS_SYSTEM);

        System.debug('Metadata update job ID: ' + jobId);
    }
}

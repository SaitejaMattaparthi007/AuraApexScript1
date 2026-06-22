<?xml version="1.0" encoding="UTF-8"?>
<!--
    Rule: sfmeta:CommunityGuestUserAccess
    Condition C: Guest User Profile has Apex Class access enabled
    Triggers when:
      - classAccesses with enabled = true
-->
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Customer Community Guest User</fullName>
    <custom>false</custom>
    <userLicense>Guest User</userLicense>

    <!-- TRIGGER: Apex class access enabled -->
    <classAccesses>
        <apexClass>AccountController</apexClass>
        <enabled>true</enabled>  <!-- APEX ACCESS FOR GUEST - should trigger -->
    </classAccesses>

    <!-- TRIGGER: Apex class access enabled -->
    <classAccesses>
        <apexClass>ContactService</apexClass>
        <enabled>true</enabled>  <!-- APEX ACCESS FOR GUEST - should trigger -->
    </classAccesses>

    <!-- TRIGGER: Apex class access enabled -->
    <classAccesses>
        <apexClass>PaymentProcessor</apexClass>
        <enabled>true</enabled>  <!-- APEX ACCESS FOR GUEST - should trigger -->
    </classAccesses>

    <!-- TRIGGER: Apex class access enabled -->
    <classAccesses>
        <apexClass>DataExportUtility</apexClass>
        <enabled>true</enabled>  <!-- APEX ACCESS FOR GUEST - should trigger -->
    </classAccesses>

    <!-- TRIGGER: Apex class access enabled -->
    <classAccesses>
        <apexClass>UserManagementHelper</apexClass>
        <enabled>true</enabled>  <!-- APEX ACCESS FOR GUEST - should trigger -->
    </classAccesses>

    <!-- TRIGGER: Apex class access enabled -->
    <classAccesses>
        <apexClass>BulkDataLoader</apexClass>
        <enabled>true</enabled>  <!-- APEX ACCESS FOR GUEST - should trigger -->
    </classAccesses>

    <!-- NOT a trigger: Apex class access disabled -->
    <classAccesses>
        <apexClass>InternalOnlyService</apexClass>
        <enabled>false</enabled>  <!-- DISABLED - should NOT trigger -->
    </classAccesses>

    <!-- NOT a trigger: Apex class access disabled -->
    <classAccesses>
        <apexClass>AdminUtility</apexClass>
        <enabled>false</enabled>  <!-- DISABLED - should NOT trigger -->
    </classAccesses>
</Profile>

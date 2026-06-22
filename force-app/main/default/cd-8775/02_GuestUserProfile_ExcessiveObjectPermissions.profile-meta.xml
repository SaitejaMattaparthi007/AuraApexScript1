<?xml version="1.0" encoding="UTF-8"?>
<!--
    Rule: sfmeta:CommunityGuestUserAccess
    Condition A: Guest User Profile has excessive OBJECT-LEVEL permissions
    Triggers when:
      - allowRead = true on Account, Contact, Lead, User, or custom objects (__c)
      - allowCreate/Edit/Delete = true on any object
-->
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Customer Community Guest User</fullName>
    <custom>false</custom>
    <userLicense>Guest User</userLicense>

    <!-- TRIGGER: allowRead on Account (sensitive standard object) -->
    <objectPermissions>
        <object>Account</object>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>  <!-- EXCESSIVE - should trigger -->
        <modifyAllRecords>false</modifyAllRecords>
        <viewAllRecords>true</viewAllRecords>  <!-- EXCESSIVE - should trigger -->
    </objectPermissions>

    <!-- TRIGGER: allowRead on Contact (sensitive standard object) -->
    <objectPermissions>
        <object>Contact</object>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>  <!-- EXCESSIVE - should trigger -->
        <modifyAllRecords>false</modifyAllRecords>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>

    <!-- TRIGGER: allowRead on Lead (sensitive standard object) -->
    <objectPermissions>
        <object>Lead</object>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>true</allowEdit>  <!-- EXCESSIVE - should trigger -->
        <allowRead>true</allowRead>  <!-- EXCESSIVE - should trigger -->
        <modifyAllRecords>false</modifyAllRecords>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>

    <!-- TRIGGER: allowRead on User (sensitive standard object) -->
    <objectPermissions>
        <object>User</object>
        <allowCreate>false</allowCreate>
        <allowDelete>false</allowDelete>
        <allowEdit>false</allowEdit>
        <allowRead>true</allowRead>  <!-- EXCESSIVE - should trigger -->
        <modifyAllRecords>false</modifyAllRecords>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>

    <!-- TRIGGER: allowRead on Custom Object (__c) -->
    <objectPermissions>
        <object>Customer_Data__c</object>
        <allowCreate>true</allowCreate>  <!-- EXCESSIVE - should trigger -->
        <allowDelete>true</allowDelete>  <!-- EXCESSIVE - should trigger -->
        <allowEdit>true</allowEdit>  <!-- EXCESSIVE - should trigger -->
        <allowRead>true</allowRead>  <!-- EXCESSIVE - should trigger -->
        <modifyAllRecords>false</modifyAllRecords>
        <viewAllRecords>true</viewAllRecords>
    </objectPermissions>

    <!-- TRIGGER: allowCreate/Edit/Delete on Opportunity -->
    <objectPermissions>
        <object>Opportunity</object>
        <allowCreate>true</allowCreate>  <!-- EXCESSIVE - should trigger -->
        <allowDelete>true</allowDelete>  <!-- EXCESSIVE - should trigger -->
        <allowEdit>true</allowEdit>  <!-- EXCESSIVE - should trigger -->
        <allowRead>true</allowRead>
        <modifyAllRecords>false</modifyAllRecords>
        <viewAllRecords>false</viewAllRecords>
    </objectPermissions>

    <!-- TRIGGER: Custom object with full CRUD -->
    <objectPermissions>
        <object>Payment_Info__c</object>
        <allowCreate>true</allowCreate>  <!-- EXCESSIVE - should trigger -->
        <allowDelete>true</allowDelete>  <!-- EXCESSIVE - should trigger -->
        <allowEdit>true</allowEdit>  <!-- EXCESSIVE - should trigger -->
        <allowRead>true</allowRead>  <!-- EXCESSIVE - should trigger -->
        <modifyAllRecords>true</modifyAllRecords>  <!-- EXCESSIVE - should trigger -->
        <viewAllRecords>true</viewAllRecords>
    </objectPermissions>
</Profile>

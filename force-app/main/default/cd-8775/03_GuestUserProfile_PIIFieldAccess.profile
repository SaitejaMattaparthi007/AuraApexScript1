<?xml version="1.0" encoding="UTF-8"?>
<!--
    Rule: sfmeta:CommunityGuestUserAccess
    Condition B: Guest User Profile has field-level access to PII/sensitive fields
    Triggers when:
      - readable = true for fields matching *Email*, *Phone*, *SSN*, *Password*
-->
<Profile xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Customer Community Guest User</fullName>
    <custom>false</custom>
    <userLicense>Guest User</userLicense>

    <!-- TRIGGER: Email field readable -->
    <fieldPermissions>
        <field>Contact.Email</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Personal Email field readable -->
    <fieldPermissions>
        <field>Contact.PersonalEmail__c</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Work Email field readable -->
    <fieldPermissions>
        <field>Contact.Work_Email__c</field>
        <editable>true</editable>  <!-- EDITABLE PII - should trigger -->
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Phone field readable -->
    <fieldPermissions>
        <field>Contact.Phone</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Mobile Phone field readable -->
    <fieldPermissions>
        <field>Contact.MobilePhone</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Home Phone field readable -->
    <fieldPermissions>
        <field>Contact.HomePhone</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: SSN field readable -->
    <fieldPermissions>
        <field>Contact.SSN__c</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Social Security Number field readable -->
    <fieldPermissions>
        <field>Account.Social_Security_Number_SSN__c</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Password field readable -->
    <fieldPermissions>
        <field>Customer_Data__c.Password__c</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Temp Password field readable -->
    <fieldPermissions>
        <field>Customer_Data__c.Temp_Password__c</field>
        <editable>true</editable>  <!-- EDITABLE PASSWORD - should trigger -->
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Account Email field -->
    <fieldPermissions>
        <field>Account.Email_Address__c</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- TRIGGER: Lead Phone field -->
    <fieldPermissions>
        <field>Lead.Phone</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- PII FIELD EXPOSED - should trigger -->
    </fieldPermissions>

    <!-- Non-PII field - should NOT trigger -->
    <fieldPermissions>
        <field>Account.Name</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- NOT PII - should NOT trigger -->
    </fieldPermissions>

    <!-- Non-PII field - should NOT trigger -->
    <fieldPermissions>
        <field>Account.Industry</field>
        <editable>false</editable>
        <readable>true</readable>  <!-- NOT PII - should NOT trigger -->
    </fieldPermissions>
</Profile>

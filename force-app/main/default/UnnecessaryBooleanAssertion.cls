@IsTest
public class UnnecessaryBooleanAssertion_NonCompliant {

    // Example 1 – Basic unnecessary assertions
    static testMethod void sampleTest1() {
        Assert.isTrue(true);                // Noncompliant
        Assert.isFalse(false);              // Noncompliant
        System.assert(true);                // Noncompliant
        System.assertEquals(true, true);    // Noncompliant
    }

    // Example 2 – In a helper method
    static testMethod void sampleTest2() {
        verifyConditions();
    }
    private static void verifyConditions() {
        Assert.isTrue(true);                // Noncompliant
        Assert.isFalse(false);              // Noncompliant
    }

    // Example 3 – After try-catch flow
    static testMethod void sampleTest3() {
        try {
            someFailingMethod();
        } catch (Exception e) {
            // Expected
        }
        Assert.isTrue(true);                // Noncompliant
        System.assert(true);                // Noncompliant
    }
    private static void someFailingMethod() {
        throw new AuraHandledException('Simulated error');
    }

    // Example 4 – Inside loops
    static testMethod void sampleTest4() {
        for (Integer i = 0; i < 3; i++) {
            Assert.isFalse(false);          // Noncompliant
        }
    }

    // Example 5 – Inside condition branches
    static testMethod void sampleTest5() {
        if (true) {
            Assert.isTrue(true);            // Noncompliant
        } else {
            Assert.isFalse(false);          // Noncompliant
        }
    }

    // Example 6 – Assertions with messages
    static testMethod void sampleTest6() {
        Assert.isTrue(true, 'Literal true');       // Noncompliant
        Assert.isFalse(false, 'Literal false');    // Noncompliant
    }

    // Example 7 – In Test Setup
    @TestSetup
    static void setup() {
        Assert.isTrue(true);                // Noncompliant
    }

    // Example 8 – Multiple unnecessary assertions
    static testMethod void sampleTest7() {
        System.assert(true);                // Noncompliant
        Assert.isTrue(true);                // Noncompliant
        Assert.isFalse(false);              // Noncompliant
    }

    // Example 9 – Through utility method
    static testMethod void sampleTest8() {
        TestUtility.verifyRedundant();
    }
}

public class TestUtility {
    public static void verifyRedundant() {
        Assert.isTrue(true);                // Noncompliant
    }
}

@IsTest
private class UnnecessaryBooleanAssertion_Sonar_DemoTest {

    @IsTest
    static void unnecessaryBooleanAssertions() {
        Boolean flagTrue = true;
        Boolean flagFalse = false;

        // ❌ Sonar rule: sf:UnnecessaryBooleanAssertion
        // These assertions are unnecessary because assert() expects a boolean already.
        System.assertEquals(true, flagTrue);
        System.assertEquals(false, flagFalse);

        // Also typically flagged by the same rule:
        System.assertEquals(true, 1 == 1);
        System.assertEquals(false, 1 > 2);

        // Similar pattern (often flagged depending on ruleset):
        System.assertEquals(true, flagTrue && (2 > 1));
        System.assertEquals(false, flagFalse || (2 < 1));

        // Another common variant:
        System.assertEquals(true, !flagFalse);
        System.assertEquals(false, !flagTrue);
    }
}

// Intentionally bad Apex to trigger SonarQube rule: sf:UnnecessaryBooleanAssertion
// (Assertions with boolean literals / constant boolean outcomes)

@IsTest
public class Sonar_UnnecessaryBooleanAssertion_MoreExamples {

    @IsTest
    static void testBooleanLiteralAssertions() {

        // 1) Literal true/false passed directly
        System.assert(true);                         // violation
        System.assert(false == false);               // violation (always true)
        System.assert(!false);                       // violation (always true)

        // 2) assertEquals / assertNotEquals with boolean literals
        System.assertEquals(true, true);             // violation
        System.assertEquals(false, false);           // violation
        System.assertNotEquals(true, false);         // violation
        System.assertNotEquals(false, true);         // violation

        // 3) Comparing constant expressions
        System.assert(1 == 1);                       // violation (always true)
        System.assert(5 > 1);                        // violation (always true)
        System.assert('a' == 'a');                   // violation (always true)

        // 4) Boolean expression forced into literal comparison style
        System.assertEquals(true, 10 > 5);           // violation (unnecessary boolean assertion)
        System.assertEquals(false, 2 > 10);          // violation (unnecessary boolean assertion)

        // 5) Redundant literal checks (still constant)
        System.assert((true && true));               // violation (always true)
        System.assert((true || false));              // violation (always true)
        System.assert(!(false && true));             // violation (always true)
    }

    @IsTest
    static void testRedundantBooleanComparisons() {
        Boolean t = true;
        Boolean f = false;

        // These often get flagged because they are "boolean compared to literal"
        System.assert(t == true);                    // violation
        System.assert(f == false);                   // violation
        System.assert(t != false);                   // violation
        System.assert(f != true);                    // violation

        // More unnecessary boolean asserts using assertEquals
        System.assertEquals(true, t == true);        // violation
        System.assertEquals(true, f == false);       // violation
        System.assertEquals(false, t == false);      // violation
        System.assertEquals(false, f == true);       // violation
    }

    @IsTest
    static void testConstantTernaryAndNegations() {
        Boolean flag = true;

        // Constant ternary outcomes
        System.assert(true ? true : false);          // violation (always true)
        System.assert(false ? false : false);        // violation (always false)

        // Negation patterns with literals
        System.assertEquals(true, !false);           // violation
        System.assertEquals(false, !true);           // violation

        // Redundant because both branches yield same value
        System.assertEquals(true, flag ? true : true);   // violation (always true)
        System.assertEquals(false, flag ? false : false); // violation (always false)
    }
}

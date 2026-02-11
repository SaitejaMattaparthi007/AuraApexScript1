// Intentionally bad Apex test code to generate 20+ SonarQube violations
// (focused on sf:UnnecessaryBooleanAssertion / useless boolean asserts).
// DO NOT USE IN REAL TESTS.
public class Sonar_UnnecessaryBooleanAssertion_20Plus {


    static void testManyUnnecessaryBooleanAssertions() {

        Boolean t = true;
        Boolean f = false;

        // 1-2: Constant asserts
        System.assert(true);                 // ❌ always true
        System.assert(!false);               // ❌ always true

        // 3-6: Literal comparisons
        System.assertEquals(true, true);     // ❌ meaningless
        System.assertEquals(false, false);   // ❌ meaningless
        System.assertNotEquals(true, false); // ❌ meaningless
        System.assertNotEquals(false, true); // ❌ meaningless

        // 7-10: Expression compared to true/false
        System.assertEquals(true, 10 > 5);     // ❌ unnecessary boolean assertion
        System.assertEquals(false, 5 > 10);    // ❌ unnecessary boolean assertion
        System.assertEquals(true, (1 + 1) == 2);
        System.assertEquals(false, (2 * 2) == 5);

        // 11-14: Redundant boolean equality/inequality checks
        System.assert(t == true);   // ❌ redundant
        System.assert(t != false);  // ❌ redundant
        System.assert(f == false);  // ❌ redundant
        System.assert(f != true);   // ❌ redundant

        // 15-18: Negation compared to true/false
        System.assertEquals(true, !f);     // ❌ unnecessary boolean assertion
        System.assertEquals(false, !t);    // ❌ unnecessary boolean assertion
        System.assertEquals(true, !(1 > 2));
        System.assertEquals(false, !(2 > 1));

        // 19-22: Constant relational expressions
        System.assert(1 == 1);       // ❌ always true
        System.assert(2 != 3);       // ❌ always true
        System.assert(5 > 1);        // ❌ always true
        System.assert(1 < 100);      // ❌ always true

        // 23-26: Constant logical expressions
        System.assert(true && true);     // ❌ always true
        System.assert(true || false);    // ❌ always true
        System.assert(!(false && true)); // ❌ always true
        System.assert(!false || false);  // ❌ always true

        // 27-30: Boolean expressions compared to true/false again
        System.assertEquals(true, t && (3 > 2));     // ❌ unnecessary boolean assertion
        System.assertEquals(false, f && (3 > 2));    // ❌ unnecessary boolean assertion
        System.assertEquals(true, t || (1 > 2));     // ❌ unnecessary boolean assertion
        System.assertEquals(false, f || (1 < 2));    // ❌ unnecessary boolean assertion (this is true)

        // 31-34: More redundant boolean comparisons
        System.assert((t == true) == true);     // ❌ redundant chain
        System.assert((f == false) == true);    // ❌ redundant chain
        System.assert((t != false) == true);    // ❌ redundant chain
        System.assert((f != true) == true);     // ❌ redundant chain

        // 35-38: Assertions with constant ternaries
        System.assert((true ? true : false));         // ❌ always true
        System.assertEquals(true, (true ? t : f));    // ❌ unnecessary boolean assertion
        System.assertEquals(false, (false ? t : f));  // ❌ unnecessary boolean assertion (false ? t : f => f)
        System.assertEquals(true, (t ? true : true));

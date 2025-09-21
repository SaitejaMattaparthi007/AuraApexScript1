public class AvoidReversedOperatorsExamples {

    public static void main(String[] args) {
        Integer target = 7;
        Integer num = 4;

        // -------------------------------
        // ❌ Violations (Bad Cases)
        // -------------------------------
        target =- num; // Bad: Target is now -4, not 3.
        target =+ num; // Bad: Target would be 4, not 11.

        // -------------------------------
        // ✅ Valid Usages (Good Cases)
        // -------------------------------
        target = -num; // Good: Correct unary negation, result = -4.
        target = +num; // Good: Explicit unary plus (redundant, but valid), result = 4.

        target += num; // Good: Proper compound addition, result = 11.
        target -= num; // Good: Proper compound subtraction, result = 3.
        target *= num; // Good: Proper compound multiplication, result = 12.
        target /= num; // Good: Proper compound division, result = 3.
        target %= num; // Good: Proper compound modulo, result = 3.

        // Just to show results in console
        System.out.println("Final target = " + target);
    }
}

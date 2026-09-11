public class NopmdTestCases1 {

    public static String groupA() {
        String a1 = 'x'; // NOPMD
        String a2 = 'x'; // NOPMD
        String a3 = 'x'; //    NOPMD
        String a4 = 'x'; // NOPMD
        String a5 = 'x'; // NOPMD - reviewed by team
        String a6 = 'x'; // NOPMD:RuleA
        String a7 = 'x'; // NOPMD:RuleA,RuleB
        String a8 = 'x'; // NOPMDEXTRA

        // Use every variable so they aren't just unused local variables.
        return a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8;
    }
}

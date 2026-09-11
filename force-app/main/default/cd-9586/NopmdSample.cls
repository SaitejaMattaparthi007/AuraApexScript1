public class NopmdTestCases1 {
    void groupA() {
        String a1 = 'x'; //NOPMD
        String a2 = 'x'; // NOPMD
        String a3 = 'x'; //   NOPMD
        String a4 = 'x'; //	NOPMD
        String a5 = 'x'; //NOPMD - reviewed by team
        String a6 = 'x'; //NOPMD:RuleA
        String a7 = 'x'; //NOPMD:RuleA,RuleB
        String a8 = 'x'; //NOPMDEXTRA
    }
} //NOPMD

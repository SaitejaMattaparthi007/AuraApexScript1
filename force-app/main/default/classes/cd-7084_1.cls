@SuppressWarnings("all") class Alpha { }                  // should be violation
@suppresswarnings("all") class Beta { }                   // should be violation
@SUPPRESSWARNINGS("all") class Gamma { }                  // should be violation
@Suppresswarnings("all") class Delta { }                  // should be violation
@SuPpReSsWaRnInGs("all") class Epsilon { }                // should be violation
 
class Zeta {
    @SuppressWarnings("unused") private void m1() {}       // should be violation
    @suppresswarnings("unused") private void m2() {}       // should be violation
    @SUPPRESSWARNINGS("unused") private void m3() {}       // should be violation
    @Suppresswarnings("unused") private void m4() {}       // should be violation
    @SuPpReSsWaRnInGs("unused") private void m5() {}       // should be violation
}

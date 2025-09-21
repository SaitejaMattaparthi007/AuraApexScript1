public class EmptyStringConcatCases {
    // =========================
    // SHOULD BE REPORTED (violations)
    // =========================

    // Empty string with numeric/boolean literals
    public static void v01() { String s = '' + 123; }                  // violation
    public static void v02() { String s = 123 + ''; }                  // violation
    public static void v03() { String s = '' + -42; }                  // violation
    public static void v04() { String s = '' + true; }                 // violation
    public static void v05() { String s = false + ''; }                // violation
    public static void v06() { String s = '' + 3.14; }                 // violation
    public static void v07() { String s = 3.14 + ''; }                 // violation
    public static void v08() { String s = '' + 5L; }                   // violation
    public static void v09() { String s = 5L + ''; }                   // violation

    // Empty string with string/char-like literals
    public static void v10() { String s = '' + 'abc'; }                // violation
    public static void v11() { String s = 'abc' + ''; }                // violation
    public static void v12() { String s = 'A' + '' + 'B'; }             // violation
    public static void v13() { String s = 'A' + '' + 1 + 'B'; }         // violation
    public static void v14() { String s = 1 + '' + 2; }                 // violation
    public static void v15() { String s = 'ab' + '' + 3; }              // violation
    public static void v16() { String s = '' + 'x' + 9; }               // violation

    // Parentheses shouldn’t hide it
    public static void v17() { String s = ('' + 1) + 2; }               // violation
    public static void v18() { String s = 1 + ('' + 2); }               // violation
    public static void v19() { String s = (('' + 'a')) + 'b'; }         // violation

    // Chained with more literals
    public static void v20() { String s = 0 + '' + 0 + '' + 0; }        // violation
    public static void v21() { String s = '' + 0 + '' + 'z'; }          // violation

    // Your new mixed chain case
    public static void v24() { String s = '' + 123 + 987 + oiy + oi98; } // violation: starts with empty+literal then variables

    // =========================
    // EXTRA: Using '-' operator with empty string and literals (invalid)
    // =========================
    public static void v25() { String s = '' - 123; }                   // violation: empty string with minus literal
    public static void v26() { String s = 123 - ''; }                   // violation: literal with minus empty string
    public static void v27() { String s = '' - -42; }                   // violation: empty string with negative literal
    public static void v28() { String s = ('' - 1) - 2; }                // violation: inside parentheses
}

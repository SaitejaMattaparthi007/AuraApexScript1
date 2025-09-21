public class SwitchOnWhenExamples {

    public void bar() {
        Integer x = 2;

        // =====================
        // BAD: Missing default
        // =====================
        switch on x {
            when 1 { 
                Integer j = 6;
            }
            when 2 { 
                Integer j = 8;
            }
            // Bad: Missing a default.
        }
        
        // =====================
        // GOOD: Has default (when else)
        // =====================
        switch on x {
            when 1 { 
                Integer j = 6;
            }
            when 2 { 
                Integer j = 8;
            }
            when else {
                Integer j = 100;  // Good: a default case is specified.
            }
        }
    }
}

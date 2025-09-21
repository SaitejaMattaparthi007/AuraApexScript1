@isTest
public class ResourceInjectionTest {

    // ************* NEGATIVE CASES (should be flagged) *************

    public class Negative {
        public PageReference init() {
            String FirstName = 'John';
            String LastName = 'Doe';
            String someStringUnknown = 'something';

            // violation: two unsanitized variables directly concatenated into URL
            PageReference pg1 = new PageReference('/Authorization/PartnerRegistration/v1/RegisterDeveloper?FirstName='
                + FirstName + '&LastName=' + LastName); // violation

            // violation: unsanitized variable used directly
            String internalEndpoint = '/Authorization/v1' + someStringUnknown; // violation
            PageReference pg2 = new PageReference(internalEndpoint); // violation

            // sanitized before use - should NOT be flagged
            internalEndpoint = String.escapeSingleQuotes(internalEndpoint); // no violation
            PageReference pg3 = new PageReference(internalEndpoint); // no violation

            return pg1;
        }
    }


    public class SomeClass {
        public void otherMethod() {
            String oneMore = 'Smith';
            init(oneMore);
        }

        public PageReference init(String Lastname) {
            String FirstName = 'Jane';
            // violation: Lastname from parameter, not sanitized
            PageReference pg = new PageReference('/Authorization/v1' + Lastname); // violation
            return pg;
        }
    }


    public class Positive {
        public void init() {
            String FirstName = 'Jack';
            // violation: risky string construction (unsanitized concatenation)
            String var = '/Authorization/PartnerRegistration/v1/RegisterDeveloper?FirstName=' + FirstName; // violation
            PageReference pg = new PageReference(var); // violation
        }
    }


    // ************* POSITIVE / SAFE CASES (should NOT be flagged) *************

    public class SafeCases {
        public void safeInit() {
            String idStr = '001xx000003DGbP';
            String cleanId = String.valueOf(Id.valueOf(idStr)); // no violation
            String cleanParam = String.escapeSingleQuotes('abc123'); // no violation

            // no violation - using sanitized variables
            String safeUrl = '/apex/MyPage?id=' + cleanId + '&param=' + cleanParam; // no violation
            PageReference safePg = new PageReference(safeUrl); // no violation
        }

        public void noVariableConcatenation() {
            // no violation - static string, no variables
            PageReference pg = new PageReference('/apex/MyStaticPage'); // no violation
        }
    }


    // ************* TEST METHODS *************

    @isTest
    static void testNegativeScenarios() {
        Negative n = new Negative();
        n.init();

        SomeClass sc = new SomeClass();
        sc.otherMethod();

        Positive p = new Positive();
        p.init();
    }

    @isTest
    static void testSafeScenarios() {
        SafeCases s = new SafeCases();
        s.safeInit();
        s.noVariableConcatenation();
    }
}

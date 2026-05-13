public class DuplicateLiteralTest {

    public void testMethod() {

        // Same literal repeated multiple times → should trigger rule
        System.debug('ERROR_MESSAGE');
        System.debug('ERROR_MESSAGE');
        System.debug('ERROR_MESSAGE');
        System.debug('ERROR_MESSAGE');

        // Another duplicate set
        String a = 'DuplicateValue';
        String b = 'DuplicateValue';
        String c = 'DuplicateValue';

        // Inside method calls
        process('SAME_LITERAL');
        process('SAME_LITERAL');
        process('SAME_LITERAL');
        process('SAME_LITERAL');
    }

    private void process(String input) {
        System.debug(input);
    }
}

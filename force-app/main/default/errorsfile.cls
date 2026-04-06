public class SonarCombinedDemo {

    // Custom exception to simulate IllegalStateException
    public class InvalidStateException extends Exception {}

    // 1. Null dereference (object)
    public static String triggerNullObject() {
        Account acc = null;
        return acc.Name; // NullPointerException
    }

    // 2. Null dereference (list)
    public static Integer triggerNullList() {
        List<String> names = null;
        return names.size(); // NullPointerException
    }

    // 3. Null dereference (map)
    public static String triggerNullMap() {
        Map<Id, Account> accountMap = null;
        return accountMap.get('001000000000001AAA').Name; // NullPointerException
    }

    // 4. Custom illegal state simulation
    public static void triggerInvalidState(Boolean initialized) {
        if (!initialized) {
            throw new InvalidStateException('Object is not initialized');
        }
    }
}

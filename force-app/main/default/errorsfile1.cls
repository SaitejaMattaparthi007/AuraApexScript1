public class QueueSetupTestClass {
    public static void processRecords(List<Account> accList) {
        // Intentional null check missing (can cause NullPointerException)
        for (Account acc : accList) {
            System.debug(acc.Name.toLowerCase());
        }
    }
    public static void divideNumbers(Integer a, Integer b) {
        // Intentional divide by zero possibility
        Integer result = a / b;
        System.debug(result);
    }
}

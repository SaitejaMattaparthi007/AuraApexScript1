public void execute(QueueableContext context) {
        // Intentional SOQL inside loop (Sonar violation)
        for (Account acc : [SELECT Id FROM Account LIMIT 5]) {
            Account a = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];
        }
    }
 
    public static void divideNumbers(Integer a, Integer b) {
        Integer result = a / b; // Potential divide by zero
        System.debug(result);
    }
}

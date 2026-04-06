public class QueueSetupTestClass implements Queueable {
 
    public void execute(QueueableContext context) {
        for (Account acc : [SELECT Id FROM Account LIMIT 5]) {
            // SOQL inside loop (violation)
            Account a = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];
        }
    }
 
    public static void riskyMethod(List<Account> accList) {
        // Missing null check (violation)
        for (Account acc : accList) {
            System.debug(acc.Name);
        }
    }
}

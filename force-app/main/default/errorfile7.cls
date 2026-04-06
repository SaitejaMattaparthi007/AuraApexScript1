public class QueueSetupTestClass implements Queueable {

    public void execute(QueueableContext context) {
        // Force runtime failure
        Integer x = 10 / 0; // Divide by zero → Queue job fails
    }
}

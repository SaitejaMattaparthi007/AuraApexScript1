public class PIIExample1 {
    public void createUser() {
        User u = new User();
        u.FirstName = 'John';
        u.LastName = 'Smith';
        u.Email_ID = 'john.smith@example.com';   // Bad: Hardcoded PII
        u.Credit_Card = '3633458216844544';
        u.LastName = 'Smith';
        insert u;
    }
}

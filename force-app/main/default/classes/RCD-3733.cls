public class PIIExample1 {
    public void createUser() {
        User u = new User();
        u.FirstName = 'John';
        u.LastName = 'Smith';
        u.Email = 'john.smith@example.com';   // Bad: Hardcoded PII
        u.Credit_Card = 3633458216844544;
        u.LastName = 'Smith';
        u.name_cc = 'John Smith';
        u.phone_number = 9988448899;
        u.email_cc = 'john.smith@example.com';   // Bad: Hardcoded PII
        insert u;
    }
}

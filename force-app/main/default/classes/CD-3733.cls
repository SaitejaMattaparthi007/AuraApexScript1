public class PIIExample1 {
    public void createUser() {
        User u = new User();
        u.FirstName = 'John';
        u.LastName = 'Smith';
        u.Email = 'john.smith@example.com';   // Bad: Hardcoded PII
        insert u;
    }
}

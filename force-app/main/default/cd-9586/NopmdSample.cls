public class NopmdSample {
    public static void main(String[] args) {
        int count = 0;
        String status = "ACTIVE";
        System.out.println(status);
        count++;
        System.out.println(count); // NOPMD
        if (count > 0) {
            System.out.println("Count is positive");
        }
        String unused = "test"; // NOPMD
        System.out.println("Done");
    }
}

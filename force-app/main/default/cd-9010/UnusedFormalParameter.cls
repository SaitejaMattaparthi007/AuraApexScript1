public with sharing class UnusedFormalParameterTest {

    public UnusedFormalParameterTest(String constructorParam) {
        System.debug('Constructor called');
    }

    public void processAccount(String accountId) {
        System.debug('Processing account');
    }

    public static Integer calculate(Integer a, Integer b) {
        return 100;
    }

    public void partiallyUsed(String usedParam, String unusedParam) {
        System.debug(usedParam);
    }
}

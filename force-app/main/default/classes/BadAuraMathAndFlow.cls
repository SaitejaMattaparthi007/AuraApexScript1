/**
 * Intentionally bad Apex class for flow and logic violations.
 */
public with sharing class BadAuraMathAndFlow { // ❌ Aura controller naming violation

    @AuraEnabled
    public static Integer calculate(Integer a, Integer b) {

        // ❌ Magic numbers
        Integer factor = 7;

        // ❌ Possible divide-by-zero
        Integer result = (a * factor) / b;

        // ❌ Inefficient loop usage
        String trace = '';
        for (Integer i = 0; i < factor; i++) {
            trace += i + ',';
        }

        System.debug('Trace: ' + trace); // ❌ debug
        return result;
    }
}

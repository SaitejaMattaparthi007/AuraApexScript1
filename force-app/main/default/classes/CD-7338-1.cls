public with sharing class HotspotTypeReflectionViolations {
 
    // R1: Literal reflection
    public static Object makeAccountLiteral() {
        Type t = Type.forName('Account');              // Noncompliant
        return t.newInstance();                        // Noncompliant
    }
 
    // R2: Reflection from method parameter (untrusted)
    @AuraEnabled
    public static Object makeFromParam(String typeName) {
        Type t = Type.forName(typeName);               // Noncompliant
        return t.newInstance();                        // Noncompliant
    }
 
    // R3: Reflection + JSON.deserialize
    @AuraEnabled
    public static Object deserializeToType(String json, String t) {
        return JSON.deserialize(json, Type.forName(t)); // Noncompliant
    }
 
    // R4: Dynamic SObject via global describe
    @AuraEnabled
    public static SObject newSObjectByName(String sobjectName) {
        Map<String, Schema.SObjectType> g = Schema.getGlobalDescribe();
        Schema.SObjectType sot = g.get(sobjectName);   // Noncompliant (dynamic lookup)
        return sot != null ? sot.newSObject() : null;  // Noncompliant
    }
 
    // R5: Reflection with "sanitized" but still dynamic input
    public static Object makeFromWhitelist(String typeName) {
        String clean = typeName.trim().toLowerCase();
        // Even if you whitelist later, the reflection call itself is a hotspot:
        Type t = Type.forName(clean);                  // Noncompliant
        return t.newInstance();                        // Noncompliant
    }
 
    // R6: Dynamic construction + method dispatch
    public static String dynamicToString(String t) {
        Object o = Type.forName(t).newInstance();      // Noncompliant
        return String.valueOf(o);
    }
 
    // R7: Bulk reflection in loop
    public static List<Object> bulkMake(List<String> typeNames) {
        List<Object> out = new List<Object>();
        for (String n : typeNames) {
            out.add(Type.forName(n).newInstance());    // Noncompliant
        }
        return out;
    }
 
    // R8: Indirect user control via untyped JSON
    public static Object fromUntypedJson(String json) {
        Object parsed = JSON.deserializeUntyped(json);
        if (parsed instanceof Map<String, Object>) {
            String tn = (String)((Map<String, Object>)parsed).get('type');
            return Type.forName(tn).newInstance();     // Noncompliant
        }
        return null;
    }
 
    // R9: Obfuscated type name (base64)
    public static Object fromB64(String b64Type) {
        String tn = EncodingUtil.convertToHex(EncodingUtil.base64Decode(b64Type));
        // Even transformed input ultimately controls the type name:
        return Type.forName(tn).newInstance();         // Noncompliant
    }
 
    // R10: Enum type reflection
    public static Object enumReflect(String enumType) {
        Type et = Type.forName(enumType);              // Noncompliant
        return et.newInstance();                       // Noncompliant
    }
}

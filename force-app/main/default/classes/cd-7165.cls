public class Foo {
 public static testmethod void foo(String username, String password) {
  Crypto.generateDigest('MD5', blob); //BAD: not secure
 } 
}

public class Foo1 {
 public void foo(String username, String password) {
Crypto.generateDigest('SHA-256', blob); //Good: considered secure
 } 
}


public class Foo2 {
 public static testmethod void foo(String username, String password) {
  Crypto.generatemac('sha1', blob); //BAD: not secure
 } 
}

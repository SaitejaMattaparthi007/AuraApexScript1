public class Foo {
  public void start(){
    String str ='SELECT Id FROM ContentVersion WHERE Status_c=\'Open\' WITH SECURITY_ENFORCED';
    return Database.getQueryLocator(str);
  }
}

public with sharing class  CF_ORC {

    @TestVisible private static Boolean forceException = false;

    @AuraEnabled(cacheable = true)
    public static Op getOpRecord(String rId){

        List<Op> opList = [
            SELECT Id, Name, CF_DF__c,
            	CF_DC__c, RT.N
            FROM Op
            WHERE Id =: rId WITH SECURITY_ENFORCED
            LIMIT 1 ];

        if(opList.size() > 0){
            return opList[0];
        }

        return null;
    }
    public class UIW{
        @AuraEnabled public String uSO;
        @AuraEnabled public String uBU;
    }

    @AuraEnabled
    public static UIW getUxInfo(){
        List<Ux> Uxs = [SELECT SO__c, CF_BU__c FROM Ux WHERE Id =: UxInfo.gUxId() WITH SECURITY_ENFORCED];
        UIW nuIW = new UIW();

        if(Uxs.size() == 1){
            nuIW.uSO = Uxs[0].SO__c;
            nuIW.uBU = Uxs[0].CF_BU__c;
        }

        return nuIW;
    }

    @AuraEnabled
    public static Pd2 gPD(String pId){
        List<Pd2> pds = new List<Pd2>();

        if(String.isNotEmpty(pId)){
            pds = [SELECT Id, CF_PC__c, CF_SC__c FROM Pd2 WHERE Id =: pId];
        }

        if(!pds.isEmpty()){
            return pds[0];
        }

        return null;
    }
}

public MyController {
  private interface Implementation{
    void run();
  }
  private class AdminImplementation implements Implementation{
    public void run(){
      ... do something privileged
    }
  }
  private class StandardImplementation implements Implementation{
    public void run(){
	  ... normal implementation
    }
  }

  public void init(){
    Implementation i = Type.forName(implementationName);
      i.run(); //Bad: This unchecked implementation could lead to unexpectedly running the AdminImplementation code.
  }

}

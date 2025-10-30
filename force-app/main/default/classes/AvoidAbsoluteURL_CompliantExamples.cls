// Examples that should be COMPLIANT with AvoidAbsoluteURL (no absolute URLs)
public with sharing class AvoidAbsoluteURL_CompliantExamples {
    public static void runExamples() {
        // Relative REST endpoints (preferred)
        String rel1 = '/services/data/v59.0/sobjects/Account';
        String rel2 = '/apex/MyCustomPage?param=1';

        // Building URL from org base URL dynamically (example pattern, not absolute literal)
        String base = URL.getSalesforceBaseUrl().toExternalForm(); // Framework-resolved at runtime
        String dynamicEndpoint = base + '/services/apexrest/v1/order';

        // Using Named Credential to avoid hardcoded domain
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        // Example named credential 'My_SF_API' set in org; endpoint path only
        req.setEndpoint('callout:My_SF_API/services/data/v59.0/limits');
        Http h = new Http();
        HttpResponse res = h.send(req);
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

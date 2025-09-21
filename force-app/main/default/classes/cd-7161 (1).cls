public class Negative {
  public PageReference init(){
      APIReturn result = new APIReturn();
      HttpResponse http = new HttpResponse();
      try {
        HttpRequest req = new HttpRequest();
        // direct string in sink with two vars concatenated FirstName and Lastname. Both unsanitized. 2 violations here
        req.setEndpoint('callout:Third_Party_Authorization/PartnerRegistration/v1/RegisterDeveloper?FirstName='+FirstName+'&LastName='+Lastname);
        request.setMethod ('POST');

        // No violation here since string sanitized
        sanitizeUrl(FirstName);
        sanitizeUrl(LastName);
        PageReference pg = new PageReference('callout:Third_Party_Authorization/PartnerRegistration/v1/RegisterDeveloper?FirstName='+FirstName+'&LastName='+LastName);

        // only string no variables concatenated. no violation
        req.setEndpoint('http:Third_Party_Authorization/v1');

        // violation here
        String internalEndpoint = 'https:Third_Party_Authorization/v1' + someStringUnknown;
        // unsanitized variable internalEndpoint used. violation here
        PageReference pg = new PageReference(internalEndpoint);

        internalEndpoint = String.escapeSingleQuotes(internalEndpoint);
        // sanitized variable internalEndpoint with default sanitization methods. No violation here
        req.setEndpoint(internalEndpoint);

      }
  }
}

public class someClass {
  public void otherMethod() {
    String oneMore = 'somethingHere';
    init(oneMore);
  }

  public PageReference init(String Lastname){
      String FirstName = getName();
      try {
        HttpRequest req = new HttpRequest();
        // Lastname variable coming from method param. inside the method "otherMethod" Lastname was not sanitized. violation thrown
        req.setEndpoint('https:Third_Party_Authorization/v1'+Lastname);
        request.setMethod ('POST');
      }
  }
}

public class Positive {
  public void init(){
      // violation here as risky string constructed(with unsanitized concatentations)
       String var = 'http:Third_Party_Authorization/PartnerRegistration/v1/RegisterDeveloper?FirstName='+FirstName;
  }
}

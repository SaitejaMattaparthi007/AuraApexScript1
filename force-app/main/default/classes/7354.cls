public with sharing class RuleBugDemo {

    private string propertyVal = null;

    private string anotherPropertyVal {
        get{
            //this.propertyVal = 'test';
            //return this.propertyVal;
        }
        set;
    }

    public RuleBugDemo() {
        var foo = "Copyright \251";

    }
    

    public void demoMethod() {
        System.debug('Value: ' + this.anotherPropertyVal);
    }

}



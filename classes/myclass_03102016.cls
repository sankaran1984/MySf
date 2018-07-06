public with sharing class myclass_03102016 {

    public myclass_03102016(ApexPages.StandardController sc) {
        
        try {
            Merchandise__c m = (Merchandise__c) sc.getRecord();
            m.Quantity__c = 50;

        } catch(Exception e) {
            System.debug('Caught Exception here');
        }
    }
    
    public void onsave() {
            Merchandise__c m1 = [Select Id, Quantity__c From Merchandise__c Where Id =: ApexPages.currentPage().getParameters().get('Id')];
            //m1.Quantity__c = 60;
            update m1;        
    }
    
}
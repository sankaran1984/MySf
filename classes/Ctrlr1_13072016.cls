public without sharing class Ctrlr1_13072016 {
    
    public Opportunity Opportunity{get;set;}

    public Ctrlr1_13072016(){
        Opportunity = [Select Id, Account.SLA_Expired__c From Opportunity Where Id='006b0000006Gnx9AAC'];
    }
}
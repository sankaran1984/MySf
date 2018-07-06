public with sharing class testable {
    
    Public List<Merchandise__c> lsMers{get;set;}
    
    public testable(){
        lsMers = [Select Id, islaptop__c from Merchandise__c];
        System.Debug(Schema.SObjectType.Merchandise__c.Fields.isLaptop__c.isAccessible());
        System.Debug(lsMers);
        System.Debug('Accessible Fields-'+ApexUtils.getAllAccessibleFields('Merchandise__c'));
    }
}
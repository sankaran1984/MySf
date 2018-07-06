@isTest global class myTestClass5 {

    @TestVisible
    static integer i=10;
    
    @TestVisible
    static testmethod void func(){
        insert new merchandise__c(name='laptop_modified', price__c=100, Quantity__c=10);
    }
    
    @isTest
    static void func1(){
        Test.startTest();
        system.assertEquals([select id, name from merchandise__c where name='laptop_modified' limit 1].name, 'laptop_modified');
        Test.stopTest();
    }
    
}
@isTest
public class mytest {

    Public Static TestMethod void myTest(){
        System.runAs(TestDataUtils.createUser('Custom: Sales Profile', 'Test')){
            insert new Merchandise__c(Quantity__c = 20, Price__c = 20);
            Merchandise__c m = [Select Id, Quantity__c, Price__c From Merchandise__c LIMIT 1];
            m.value1__c = 20;
        	update m;               
    	}
    }
    
    
    
}
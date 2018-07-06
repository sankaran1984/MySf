trigger myTestTrigger1 on Merchandise__c (before insert, after insert) {

    if(Trigger.isBefore){ 
        System.Debug('myTestTrigger1 -Before-Trigger.size-'+Trigger.size);
        //Trigger.new[0].addError('My Custom Error');
    }
    
    List<Merchandise__c> lsMs = [Select Id From Merchandise__c LIMIT 1];
    
    if(Trigger.isAfter) System.Debug('myTestTrigger1 -After-Trigger.size-'+Trigger.size);
}
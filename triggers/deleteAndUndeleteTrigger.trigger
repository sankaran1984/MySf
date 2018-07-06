trigger deleteAndUndeleteTrigger on Merchandise__c (before delete, after delete, after undelete) {

    if(Trigger.isBefore && Trigger.isDelete)
    	System.Debug('Trigger.before-delete--Trigger.old'+Trigger.old+'--Trigger.new'+Trigger.new);
    
    if(Trigger.isAfter && Trigger.isUnDelete)
    	System.Debug('Trigger.after-undelete--Trigger.old'+Trigger.old+'--Trigger.new'+Trigger.new);
}
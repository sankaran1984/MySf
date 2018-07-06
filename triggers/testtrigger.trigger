trigger testtrigger on Merchandise__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {

    if(Trigger.isBefore){ 
        System.Debug('testtrigger -Before-Trigger.size-'+Trigger.size);
        //Trigger.new[0].addError('My Custom Error');
        
        String issue = commonUtils.enforceSecurity(Trigger.isInsert, Trigger.isUpdate, Trigger.isDelete, Trigger.isUnDelete,
        	Trigger.isDelete ? Trigger.old : Trigger.new);
        System.debug('issue - '+issue);
        if (!String.isBlank(issue)) {
            for (Merchandise__c m : Trigger.isDelete ? Trigger.old : Trigger.new) {
                m.addError(issue);
            }
        }
    }
    
    if(Trigger.isAfter) System.Debug('testtrigger -After-Trigger.size-'+Trigger.size);

}
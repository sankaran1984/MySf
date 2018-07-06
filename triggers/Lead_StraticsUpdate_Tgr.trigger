trigger Lead_StraticsUpdate_Tgr on Lead (after insert, after update) {

    List<Id> leadsToUpdate = new List<Id>();
    for (Lead l : Trigger.new) {
        if ((Trigger.isInsert || (Trigger.oldMap.get(l.Id).Do_Not_Slydial__c != Trigger.newMap.get(l.Id).Do_Not_Slydial__c))
            && l.Do_Not_Slydial__c) {
        	  leadsToUpdate.add(l.Id);      
        }
    }
    
    // We can fire 50 Future methods & each can fire 100 API calls.
    // So, 50 * 100 = 5000 is maximum leads we can update   
    for (Integer i = 0; i < 50; i++) {
        if (i*100 >= leadsToUpdate.size()) break;
        
        Set<Id> leadIds = new Set<Id>();
        for (Integer j = 0; j < 100; j++) {
            
            if (i*100 + j >= leadsToUpdate.size()) break;
    		leadIds.add(leadsToUpdate[i*100 + j]);
        }
        StraticsUpdate.fireAPI(leadIds);
    }
    
}
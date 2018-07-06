public class ArchiveJobAllocater implements Database.Batchable<sObject>{

    Archive_Job__c currentJob;
    
    Public ArchiveJobAllocater(Archive_Job__c aj){
        
    }
    
    Public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select '+ String.Join(ApexUtils.getAllFieldsForObject(currentJob.Object_Name__c), ',') +
                                             ' From ' + currentJob.Object_Name__c + 
                                             ' Where CreatedDate<LAST_N_DAYS:'+currentJob.Older_Than_Days__c+
                                             ' Order By Id Asc LIMIT 50000000');
    }
    
    Public void execute(Database.BatchableContext bc, List<sObject> lsObj){
        insert new Archive_Job_Item__c(Range__c=String.valueOf(lsObj.size()));
    }
    
    Public void finish(Database.BatchableContext bc){
        
    }
}
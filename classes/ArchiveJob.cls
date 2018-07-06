Public Class ArchiveJob implements System.Schedulable{
    
    Archive_Job__c currentJob;
    
    Public ArchiveJob(Archive_Job__c aj){
        this.currentJob = aj;
    }
    
    Public void execute(System.SchedulableContext sc){
		findRangesOfRecordsToArchive();
    }
    
    Public Class ArchiveJobException extends Exception{}
    
    /* Private Methods */
    /* We can't archive all the data in one go, due to heap size limit.
     * So, We need to find the range of Id's which we could archive safely
	 */
    Public void findRangesOfRecordsToArchive(){
        if(currentJob.Object_Name__c==Null || currentJob.Older_Than_Days__c==Null) 
            throw new ArchiveJobException('Job Record-'+ currentJob.Id +' is Iscorrect. Please Contact Sys. Admin.');
         
        List<sObject> lsObj = Database.Query('Select '+ String.Join(ApexUtils.getAllFieldsForObject(currentJob.Object_Name__c), ',') +
                                             ' From ' + currentJob.Object_Name__c + 
                                             ' Where CreatedDate<LAST_N_DAYS:'+currentJob.Older_Than_Days__c+
                                             ' Order By Id Asc LIMIT 50000' );
        
    }
    
    
    

}
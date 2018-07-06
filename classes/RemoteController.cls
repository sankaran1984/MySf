global class RemoteController {
    
    static global list<merchandise__c> lsGlobMerRecs{get;set;}
    static public list<merchandise__c> lsPubMerRecs{get;set;}
    static private list<merchandise__c> lsPriMerRecs{get;set;}
    
    @RemoteAction
    static global void searchRecords(String searchtext){
        lsPriMerRecs = [Select id, name, price__c from merchandise__c where name like :(searchtext+'%')];
    }
       
    @RemoteAction
    global static list<merchandise__c> getSearchRecords(String searchtext){
        lsGlobMerRecs = [Select id, name, price__c from merchandise__c where name like :(searchtext+'%')];
        lsPubMerRecs = [Select id, name, price__c from merchandise__c where name like :(searchtext+'%')];
        lsPriMerRecs = [Select id, name, price__c from merchandise__c where name like :(searchtext+'%')];
        return lsGlobMerRecs;
    }

}
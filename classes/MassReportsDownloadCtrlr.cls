public class MassReportsDownloadCtrlr {
    
    public List<ReportRecord> lsReports {get;set;}
    
    private Mass_Report_Download__c userRecord;
    
    public MassReportsDownloadCtrlr() {
        
        lsReports = new List<ReportRecord>();
        
        // get user selection
        Set<String> selReports = new Set<String>();
        List<Mass_Report_Download__c> lsUserSel = [
            Select 
            	Id, User_Selection__c 
            From 
            	Mass_Report_Download__c 
            Where 
            	UserId__c =: UserInfo.getUserId()];
        if (!lsUserSel.isEmpty() && lsUserSel[0].User_Selection__c != Null) {
            selReports = new Set<String>(lsUserSel[0].User_Selection__c.split(';'));
            userRecord = lsUserSel[0];
        }
        
        // get Records
        for (Report r : [Select Name From Report Where FolderName != Null LIMIT 2000]) {
            lsReports.add(new ReportRecord(r, selReports.contains(r.Id)));
        }
    }
    
    public PageReference saveUserSelection() {
        String userSelected = '';
        for (ReportRecord r : lsReports) {
			if (!r.isSelected) continue;
            
            userSelected += r.rep.Id + ';';
        }
        
        upsert new Mass_Report_Download__c(
            Id = userRecord == Null ? Null : userRecord.Id,
            UserId__c = UserInfo.getUserId(),
            User_Selection__c = userSelected
        );
        
        return Null;
    }
    
    Class ReportRecord {
        public Report rep {get;set;}
        public Boolean isSelected {get;set;}    
        
        public ReportRecord(Report r, Boolean isSelected) {
            this.rep = r;
            this.isSelected = isSelected;
        }
    }
}
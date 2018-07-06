@isTest
public class MassReportsDownloadCtrlrTest {

    private testmethod static void testMassReportDownload(){
        // Load report page
        MassReportsDownloadCtrlr m = new MassReportsDownloadCtrlr();
        System.assert(m.lsReports != Null);
        
        // Save User Selection
        m.saveUserSelection();
        System.assert(![Select Id From Mass_Report_Download__c where UserId__c =: UserInfo.getUserId()].isEmpty());
    }
}
@isTest
public class Lead_StraticsUpdate_TgrTest {

    private static testmethod void testStraticUpdate() {
        Lead l = new Lead(LastName = 'TestName', Company = 'TestCompany', Do_Not_Slydial__c = True);
        
        Test.startTest();
        insert l;
        Test.stopTest();
    }
}
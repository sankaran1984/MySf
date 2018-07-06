@isTest
public class TestRestrictContactByName {
    
    private static List<Contact> createContact(Integer no, Boolean valid){
        List<Contact> lsCon = new List<Contact>();
        for(Integer count=0; count<no; count++) lsCon.add(new Contact(FirstName='XXX'+String.valueOf(count) ,LastName=valid?'VALIDLASTNAME':'INVALIDNAME'));
        return lsCon;
    }
    
    @isTest  
    public static void testSingleValidContact(){
        list<contact> lsCon = createContact(1, True);
        
        Test.StartTest();
        Database.SaveResult s = Database.insert(lsCon, False)[0];
        Test.stopTest();
        
        System.assert(s.isSuccess());
    }
    
    @isTest  
    public static void testSingleInvalidContact(){
        list<contact> lsCon = createContact(1, False);
        
        Test.StartTest();
        Database.SaveResult s = Database.insert(lsCon, False)[0];
        Test.stopTest();
        
        System.assert(!s.isSuccess());
    }
    
    @isTest  
    public static void testBulkValidContact(){
        list<contact> lsCon = createContact(201, True);
        
        Test.StartTest();
        Database.SaveResult s = Database.insert(lsCon, False)[0];
        Test.stopTest();
        
        System.assert(s.isSuccess()); 
    }
    
    @isTest  
    public static void testBulkInvalidContact(){
        list<contact> lsCon = createContact(201, False);
        
        Test.StartTest();
        Database.SaveResult s = Database.insert(lsCon, False)[0];
        Test.stopTest();
        
        System.assert(!s.isSuccess());
    }
}
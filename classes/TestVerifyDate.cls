@isTest
public class TestVerifyDate {
    
    @isTest
    public static void testCheckDatesWithNoInput(){
        try{
            VerifyDate.CheckDates(NULL, NULL);
        }catch(Exception e){
            System.Debug('Test Passed');
        }
    }
    
    @isTest
    public static void testCheckDatesWithPositiveCases(){
        System.assertEquals( VerifyDate.CheckDates(Date.newInstance(2015, 01, 01), Date.newInstance(2015, 01, 10)),
                            Date.newInstance(2015, 01, 10));
    }
    
    @isTest
    public static void testCheckDatesWithNegativeCases(){
        System.assertEquals( VerifyDate.CheckDates(Date.newInstance(2015, 01, 01), Date.newInstance(2015, 02, 01)),
                            Date.newInstance(2015, 01, 31));
    }
}
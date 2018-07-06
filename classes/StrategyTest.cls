@isTest
public class StrategyTest {

    public static testmethod void testStrategy(){
        System.Assert(Strategy.getCurrentTemperature('Google') == 'Google Service Down');
        System.Assert(Strategy.getCurrentTemperature('Yahoo') == 'Yahoo Service Down');
        System.Assert(Strategy.getCurrentTemperature(Null) == Null);
        System.Assert(Strategy.getCurrentTemperature('') == Null);
        
        try{
        	Strategy.getCurrentTemperature('Dummy');
        }catch(Exception e){
            System.Assert(e instanceOf Strategy.StrategyException);
            System.Assert(e.getMessage() == 'Invalid_Service_Name');
        }
    }
}
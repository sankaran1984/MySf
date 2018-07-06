@isTest
public class DecoratorTest {
    
    @TestSetup
    Public Static void testSetupData(){
        List<Opportunity> lsOpps = new List<Opportunity>();
        
        //Create ten Opportunity 
        for(Integer i=0; i<15; i++) 
            lsOpps.add(new Opportunity(Name='Opp'+i, CloseDate=System.Today()+10, StageName='Closed Won'));
        
        insert lsOpps;
    }

    Public Static testmethod void testDecorator(){
        Decorator d = new Decorator();
     
        System.Assert(d.lsOpps.size() == 15);
        
        System.Assert(d.lsOpps[0].closeDate == String.valueOf(d.lsOpps[0].opp.CloseDate.Year()));
        
        d.lsOpps[0].closeDate = String.valueOf(System.Today().Year()+2);
        System.Assert(d.lsOpps[0].opp.closeDate.Year() == System.Today().Year()+2);
    }
    
}
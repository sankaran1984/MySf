public class testclass6_22022017 {
    
    public OpportunityWrapper oppWrapObj {get;set;} 

    public testclass6_22022017() {
        oppWrapObj = new OpportunityWrapper(ApexPages.currentPage().getParameters().get('Id'));
    }
    
    class OpportunityWrapper {
        Public String genericName{get;set;}
        Public Date openDate{get;set;}
        Public Opportunity opp{get;set;}
        
        Public OpportunityWrapper(Id oppId) {
            opp = [Select Id, Name, StageName From Opportunity Where Id =: oppId]; 
            
            genericName = 'Test Opp Generic Name';
            openDate = System.Today() + 20;
        }
        
    }
    
}
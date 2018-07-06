public class Decorator {
    
    Public List<OpportunityDecorator> lsOpps{get; Private set;}
    
    Public Decorator(){
        lsOpps = new List<OpportunityDecorator>();
        for(Opportunity opp: [Select Name, CloseDate From Opportunity Where CloseDate!=Null Limit 15])
            lsOpps.add(new OpportunityDecorator(opp));
    }

    /* This decorates the Opportunity Object with extra properies - This is Decorator Pattern */
    Public Class OpportunityDecorator{
        
        Public Opportunity opp{get; private set;} 
        
        Public String closeDate{get{
                if(closeDate==Null)
                    closeDate = opp!=Null?String.valueOf(opp.closeDate.year()):Null;
                return closeDate;
            } set{
                if(opp!=Null)
                    closeDate = value;
                    opp.closeDate = Date.newInstance(Integer.valueOf(value), 
                                                           opp.closeDate.month(),
                                                           opp.closeDate.day());
        	}
        }
        
        Public OpportunityDecorator(Opportunity opp){
            this.opp = opp;
        }
        
    }
    
}
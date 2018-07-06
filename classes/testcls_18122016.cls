public class testcls_18122016 {
    
    public Integer oppCount {get; set;}

    public testcls_18122016() {
        // Do Nothing
    }
    
    public void getClosedOppCount() {
        oppCount = (Integer) [Select 
                              	Count(Id) 
                              From 
                              	Opportunity 
                              Where 
                              	IsClosed = False][0].get('expr0');
    }
}
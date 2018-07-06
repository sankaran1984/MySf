global class testcls_1_08122016 {

    public List<Opportunity> lsOpp { get; set;}
    
    public void myCustAction() {
    	lsOpp = [Select 
                     Id, Name, IsClosed 
                 From 
                     Opportunity 
                 Limit 10];
    }
    
    @RemoteAction
    public static List<Opportunity> getOpportunities() {
        return [Select 
                	Id, Name, IsClosed 
                From 
                	Opportunity 
                Limit 10];
    }
    
    webservice static List<Opportunity> getOpportunities_WS() {
        return [Select 
                	Id, Name, IsClosed 
                From 
                	Opportunity 
                Limit 10];        
    }
    
}
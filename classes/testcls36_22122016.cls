public class testcls36_22122016 {
    
    Opportunity opp;
    
    public testcls36_22122016(ApexPages.StandardController sc) {
        opp = (Opportunity) sc.getRecord();
    }

    public void changeAccount() {
        opp.Account.Name = [Select 
                            	Id, Name 
                            From 
                            	Account
                            Where 
                            	Id =: opp.AccountId
                           ][0].Name;
    } 
    
}
public class testSanPage1Ctrl {
    Public String selInput{get;set;}
    Public Contact c{get;set;}
    Public String StrName{get;set;}
    
    public List<Account> getAccounts(){
        return [select id, name, customerpriority__c, (select id, name from contacts) from Account limit 100];
    }
    
    public void sendToSrv(){
        System.Debug(selInput);
        selInput = selInput.subString(0,3);
    }
    
    public String getStrName(){
        return 'Sankaran';
	}
    
    public void setStrName(){
        system.Debug(StrName);    
    }
}
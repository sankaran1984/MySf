public class testext32_20122016 {
    
    Opportunity opp;

    public testext32_20122016(ApexPages.StandardController sc) {
        opp = (Opportunity) sc.getRecord();
    }
    
    public void save() {
        
        // Error through ApexPages.addMessage
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Save Operation not possible now.'));
        ApexPages.addMessages(new LocalException('Local Exception thrown'));
         
        // Error through addError in sObject directly.
        opp.addError('It cannot be saved now, as the Organization is locked temporarily');
        opp.Name.addError('This cannot be changed now, come back after sometime');
        
    }
    
    class LocalException extends Exception {}
}
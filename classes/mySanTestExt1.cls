public class mySanTestExt1 {
    public mySanTestExt1(ApexPages.StandardController sc){}
    
    public void saveCust(){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Sankaran Message1'));
        
    }
}
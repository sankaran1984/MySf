public class myPDFPage_Ctrl {
    
    public Opportunity opp{set;get;}
    
    public PageReference initPDFData(){
        String jsonStr = ApexPages.currentPage().getParameters().get('data');
        opp = (Opportunity)JSON.deserialize(jsonStr, sObject.class);
        return Null;
    }
}
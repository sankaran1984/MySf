public class merExt2 {
    
    ApexPages.StandardController cl;
    private List<String> fSets;
    
    public merExt2(ApexPages.StandardController c){
        cl=c;
        fSets = new List<String>{'Id', 'Price__c', 'Quantity__c', 'Invoice__c', 'Catagories__c'};
        cl.addFields(fSets);
    }
    
    public PageReference saveRec(){
        system.debug('SANK-'+((Merchandise__c)cl.getRecord()).Price__c);
        try{
            update cl.getRecord();
        }catch(Exception e){
            ApexPages.addMessages(e);
        }
        
        PageReference redPage = ApexPages.currentPage().getURL().toLowerCase().contains('mytestpage9')?Page.myTestPage8:Page.myTestPage9;
        redPage.getParameters().put('id', cl.getId());
        return redPage;
    }
    
    public List<String> getfieldList(){
        return fSets;
    }
}
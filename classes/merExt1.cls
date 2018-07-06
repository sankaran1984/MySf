public class merExt1 {
    
    public merExt1(ApexPages.StandardController c){}
    public merExt1(ApexPages.StandardSetController c){}
    
    public Boolean renderaspdf {get; set;}
    
    public list<merWrapped> getMerWithIndex()
    {
        list<merWrapped> lsm = new list<merWrapped>();
        integer i=0;
        for(merchandise__c m:[Select id, price__c, name from merchandise__c]) lsm.add(new merWrapped(m, i++));
        return lsm;
    }
    
    public list<merchandise__c> getmerobjs()
    {
        return [select id, price__c, name from merchandise__c];
    }

    public class merWrapped{
        public merchandise__c m{get;set;}
        public integer i;
        public merWrapped(merchandise__c m, integer i){ this.m=m; this.i=i;}
    }
    
    public pagereference renderNow(){
        renderaspdf = True;
        return null;
    }
}
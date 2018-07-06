public class myTestClass1 {
    
    public myTestClass1(){}
    
    public class myclass{
        private myclass(){}
        private string s;
        merchandise__c m = new merchandise__c(id='a0Cb000000KTxA7');
    }
    
    public void exec(){
        merchandise__c[] a = [select id, name from merchandise__c limit 2];
        set<myclass> s = new set<myclass>();
        s.add(new myclass());
        s.add(new myclass());
        for(myclass c:s) system.debug('success'+c.s);
    }
    
    public Integer i{get;set;}
    
    public integer geti(){return 20;}
    
    {i=15; system.debug('SANK-'+i);}
    
    void func1(merchandise__c a){
        a.name = 'laptop_modified';
    }
}
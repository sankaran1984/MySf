public class MyTestClass1_May16 {

    Public List<Merchandise__c> m{get{
        if(m==Null)
            m = [Select id, islaptop__c from merchandise__c limit 5];
        return m;
    }set;}
    
    Public void mysave(){
		System.Debug('SANK-'+m);
    }
    
}
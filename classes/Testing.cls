public class Testing{
    Public String selInp{get;set;}
    
    Public List<SelectOption> options{get{
        return new List<SelectOption>{new SelectOption('A', 'A'),
            						  new SelectOption('B', 'B'),
            						  new SelectOption('C', 'C')	
        };
    }set;}
    
    Public List<Opportunity> lsOpps{get{
        if(lsOpps!=Null) return lsOpps;
        lsOpps = [Select Id, name, stagename from Opportunity];
        System.Debug('SANK - lsOpps-'+lsOpps);
        return lsOpps;
    }set;}
    
    Public PageReference refresh(){
        return new PageReference('/apex/testsanpage2');
    }
        
    Public PageReference redirect(){
        return new PageReference('/apex/testsanpage2?viewas=csv');
    }
}
public class testMyPageCtrlr {
    public string nullstr {get;set;}
    public String param1{get;set;}
    public String param2{get;set;}
    public String divIds{get;set;}
    Public List<String> divIdsList{get{
        return divIds.split(',');
    }set;}
    
    public object obj{get{
        object o = 10;
        return o;
    }set;}
    
    public object obj1{get{
        return new Map<String, String>{'ITALY'=>'IDLY'};
    }set;}
    
    /*public sObject obj2{get{
        obj3 = [Select Id, Invoice__r.Owner.Name from Merchandise__c limit 1];
        return obj3;
    }set;}*/
    
    public sObject obj3{get;set;}
    
    Public Map<String, Object> mGrpToCount{get{
        return new Map<String, Object>{'Sankaran'=> 'Nepolean',
            							'Chandran'=> 'Nepolean'};
    }set;}
    
    Public String inpStr{get;set{
        if(value!=Null) inp = (InputParam)JSON.deserialize(value, InputParam.Class);
    }}
    
    InputParam inp;
    
    Public void invoke_fun1(){
        System.Debug('invoke_fun1 - param1-'+param1+' param2-'+param2);
        System.Debug('invoke_fun1 - inp-'+inp);
    }
    
    Class InputParam{
        Public String soql;
        Public Boolean count_sql;
    }
}
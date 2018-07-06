public class testclass1_23022017 {
    
    /* VF Bindings */
    Public String searchStr{get;set;}        
    Public Map<String, List<Map<String, String>>> results {get;set;}
    
    /* Action Function */
    public void startSearch() {
        
        List<List<sObject>> lsResults = [
             FIND 
                :searchStr
             IN 
                ALL FIELDS
             RETURNING
                Account(Name, Type),
                Opportunity(Name, StageName),
                Product2(Name, ProductCode)
            ];
        
        Map<String, List<String>> objNamesAndFields = new Map<String, List<String>>{
            'Account' => new List<String>{ 'Name', 'Type'},  
            'Opportunity' => new List<String>{ 'Name', 'StageName'}, 
            'Product2' => new List<String>{ 'Name', 'ProductCode'}};
        
        results = new Map<String, List<Map<String, String>>>();
        Integer count = 0;
        for (String objName : objNamesAndFields.keySet()) {
            results.put(objName, new List<Map<String, String>>());
            
            for (Integer idx = 0; idx < lsResults[count].size(); idx++) {
                Map<String, String> recMap = new Map<String, String>();
                
                for (String field : objNamesAndFields.get(objName)) {
                    recMap.put(field, (String) lsResults[count][idx].get(field));
                }
                
                results.get(objName).add(recMap);
            }
            
            count++;
        }
    }
}
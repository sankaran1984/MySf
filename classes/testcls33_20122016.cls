public class testcls33_20122016 {
    
    Opportunity opp;
    public Map<String, String> errorMap {get; set;}

    public testcls33_20122016(ApexPages.StandardController sc) {
        opp = (Opportunity) sc.getRecord();
        errorMap = new Map<String, String> { 'Name' => '' };
    }
    
    public void save() {
        errorMap.put('Name', 'Organization locked. Sorry for inconvinience');
    }
}
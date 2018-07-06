public class testcls9_08122016 {

    public string pageName { get; set; }
    
    public Boolean getHasAccess() {
        try {
        	PageReference newPage = new PageReference('/apex/'+pageName); 
            newPage.getContent();
        } catch(Exception e) {
            return False;
        }
        
        return True;
    }
}
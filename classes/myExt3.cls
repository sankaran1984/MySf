public class myExt3 {
    public myExt3(ApexPages.standardController c){}
    
    public PageReference save(){
        //return Page.myTestPage11.setRedirect(true);
        return ApexPages.currentPage().getURL().toLowerCase().contains('mytestpage12')?Page.myTestPage11:Page.myTestPage12;
    }
        
}
public class myTestComp2_Ctrl {

    public Opportunity oppObj{get;set;}
    
    public String pdfURL{get;set;}
    
    public myTestComp2_Ctrl(){
        pdfURL = 'initial URL';
    }
    
    public PageReference genPDFURL(){
    	PageReference p = Page.myPDFPage;
        p.getParameters().put('data', JSON.serialize(oppObj));
        
        pdfURL = p.getURL();
        return Null;
    }
}
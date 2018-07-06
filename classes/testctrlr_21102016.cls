public class testctrlr_21102016 {

    public Map<String, String[]> myCtrlList{get;set;}
    
    public Object myCompList{get;set;}
    
    public Attachment att{get;set;}
    public string message{get;set;}
    
    public testctrlr_21102016() {
        att = new Attachment();
    }
    
    public void init() {
        myCtrlList = new Map<String, String[]>();
        myCtrlList.put('mylist', new String[]{ 'Sankaran', 'Chandran', 'Suganthi'});
    }
    
    public void uploadFile() {
        message = 'File Attached - ' + String.valueOf(att.Body).length();
    }
}
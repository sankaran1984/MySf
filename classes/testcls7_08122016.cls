public class testcls7_08122016 {

    public string pagemessage { get; set;}
    
    public testcls7_08122016() {
        pagemessage = 'page initialized to default value';
    }
    
    public void init_page1() {
        pagemessage = 'page initialized by page1';
    }
    
    public void init_page2() {
        pagemessage = 'page initialized by page2';
    }    
}
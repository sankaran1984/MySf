public class testcls39_02012017 {

    public Attachment att {get; set;}
    
    public testcls39_02012017(ApexPages.StandardController sc) {
        att = new Attachment( ParentId = sc.getId());
    }
    
    public void addAttach() {
        insert att;
    }
}
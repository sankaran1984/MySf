public class testcls7_12122016 {
    
    public String name_with_createddate {get; set;}

    public testcls7_12122016(ApexPages.StandardController sc) {
        Account ac = (Account) sc.getRecord();
        name_with_createddate = ac.Name + '###' + ac.CreatedDate;
    }
    
}
public class RandomContactFactory {
    public static list<contact> generateRandomContacts(Integer no, String lName){
        List<Contact> lsCon = new List<Contact>();
        for(Integer count=1; count<=no; count++) lsCon.add(new Contact(FirstName='Test '+String.valueOf(count), LastName=lName));
        return lsCon;
    }   
}
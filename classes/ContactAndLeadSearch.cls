public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(string name){
        return [FIND :name IN NAME FIELDS RETURNING Contact(Id, name), Lead(Id, name)];
    }
}
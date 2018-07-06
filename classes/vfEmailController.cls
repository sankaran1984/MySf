public class vfEmailController {
    
    public vfEmailController(ApexPages.StandardController c){sentStatus='Message Compose';}
    
    public list<string> SelectedOptions{get;set;}
    public string subject{get;set;}
    public string body{get;set;}
    public string sentStatus{get;set;}
    
    public list<SelectOption> SelectOptions{
        set;
        get{
            list<SelectOption> lsSo = new list<SelectOption>();
            for(contact c: [select id, name, email from contact order by lastmodifieddate desc limit 10]){
                lsSo.add(new SelectOption(c.email, c.name+'-'+c.email));
            }
            return lsSo;
        } 
    }
    
    public PageReference sendEmail(){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        system.debug('SANK-'+SelectedOptions);
        email.setToAddresses(SelectedOptions);
        email.setSubject(subject);
        email.setPlainTextBody(body);
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
        
        sentStatus = 'sent successfully';
        
        return Null;
    }
}
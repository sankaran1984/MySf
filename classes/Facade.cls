public class Facade {

    /*Simple Interface to Complex Process(Sending Email) - This is called Facade Pattern */
    Public Static void sendEmail(){
        new Email().send('a@b.com', 'Hello Buddy', 'Have a Great Day');
    }
    
    Class Email{
        Public void send(String to, String subject, String body){
            Messaging.SingleEmailMessage s = new Messaging.SingleEmailMessage();
            s.setToAddresses(new List<String>{to});
            s.setSubject(subject);
            s.setPlainTextBody(body);
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{s});
        }
    }
}
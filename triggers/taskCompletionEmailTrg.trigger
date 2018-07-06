/*
    Author               : Sankaran Nepolean
    Created Date         : 18/4/2014
    Purpose              : This trigger will send email to task creator on its completion.
    Modification History : 
       1) developed from scratch on 18/4/2014 by Sankaran Nepolean  
*/
trigger taskCompletionEmailTrg on Task (after insert, after update) {
        
	//Loop through the task records and compose email for completed ones	    

	List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    
    for(Task t : Trigger.new){

        if(t.Status=='Completed' && (t.CreatedById <> t.OwnerId) ) {

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            mail.setTargetObjectId(t.CreatedById);
            
            String owner = [select Name from User where id = :t.OwnerId].Name;
            
            String creator = [select Name from User where id = :t.CreatedById].Name;
            
            //Subject
            
            mail.setSubject('Task \'' + t.Subject +'\' Completed by ' + owner);
            
            //Message Body
            
            String msg = 'Dear ' + creator + ',\n\n';
            
            msg += 'The Task \'' + t.Subject + '\' has been completed by ' + owner + '.\n';
            
            String queryString = 'select Name from ' + t.WhoId.getSObjectType() +  ' where Id = \'' + t.WhoId + '\' limit 1';
            system.debug(queryString);
            sObject[] obj = Database.query(queryString);
            msg += 'Related to: ' + t.WhoId.getSObjectType() + ' - ' + obj[0].get('Name') + '\n';
            
            
            try
            {
            	/* some objects does not have Name, hence covered it with try block*/
            	
            	queryString = 'select Name from ' + t.WhatId.getSObjectType() +  ' where Id =\'' + t.WhatId + '\' limit 1';
            	obj = Database.query(queryString);
            	msg += 'Related to: ' + t.WhatId.getSObjectType() + ' - ' + obj[0].get('Name') + '\n';
            }
            catch(Exception e)
            {
            	system.debug('Name field doesnot exist in the object');
            }
            
            msg += 'Comment:  ' + t.Description + '\n';
            
            msg += 'Due Date:  ' + t.ActivityDate + '\n';
            
            msg += 'Full Details Here:  ' + Url.getSalesforceBaseUrl().toExternalForm() + '/' + t.Id +  '\n\n';
            
            msg += 'Kind Regards,\n\n';
            
            msg += 'Contract Chair Co.';
            
            mail.setPlainTextBody(msg);
            
            mail.saveAsActivity = false;
            
            mails.add(mail);   

        }

    }
    
    //send the emails just composed
    
    if(!mails.isEmpty()){
    	
    	Messaging.sendEmail(mails);
    	
    }
	
}
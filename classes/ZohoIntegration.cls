public class ZohoIntegration {
    
    private static final String zoho_crm      = Zoho__c.getInstance().Zoho_CRM_Url__c;
    private static final String authToken     = Zoho__c.getInstance().Zoho_AuthToken__c;
    private static final Integer SUCCESS_CODE = 200;

    @future(callout = True)
    public static void pushContact(Id contactId, Boolean isCreate) {
        try {
            Contact c = getContact(contactId);
            validate(c, isCreate);
            
            HttpRequest req = buildRequest(c, isCreate);
            HttpResponse resp = Test.isRunningTest() 
                ? new HttpResponse() : new Http().send(req);
            
            logResponse(contactId, isCreate ? 'Create' : 'Update', req.getEndpoint(), resp);
            
            if (isCreate) updateZohoId(contactId, resp.getBody());
            
        } catch (Exception ze) {
            logError(contactId, ze.getMessage());
        }
    }
    
    private static Contact getContact(Id contactId) {
        return [Select
                	Id, Name, FirstName, LastName, Email, Phone, ZohoId__c
                From
               		Contact
                Where 
               		Id =: contactId];
    }
    
    private static void validate(Contact c, Boolean isCreate) {
        if (!isCreate && String.isBlank(c.ZohoId__c)) {
            throw new ZohoIntegrationException('This record doesn\'t contain Zoho Id. It\'s required to identify the record in Zoho ');
        }
    }
    
    private static HttpRequest buildRequest(Contact c, Boolean isCreate) {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        String reqUrl = zoho_crm + 'Contacts/' + 
            (isCreate ? 'insertRecords' : 'updateRecords') +
            '?authtoken=' + authToken + '&scope=crmapi&newFormat=1' + 
            (isCreate ? '' : '&id=' + c.zohoId__c) +
            '&xmlData=' + getContactAsXML(c);
        req.setEndpoint(reqUrl); 
        
        return req;
    }
    
    private static String getContactAsXML(Contact c) {
        return EncodingUtil.urlEncode('<?xml version="1.0" encoding="UTF-8" ?>' + 
            	'<Contacts>' +
					'<row no="1">' +
						'<FL val="First Name">' + c.FirstName + '</FL>' +
						'<FL val="Last Name">' + c.LastName + '</FL>' +
						'<FL val="Email">' + c.Email + '</FL>' +
						'<FL val="Phone">' + c.Phone + '</FL>' +
					'</row>' +
				'</Contacts>', 'utf-8');
    }
    
    private static void updateZohoId(Id contactId, String respBody) {
        Matcher m = Pattern.compile('(?<=<FL val="Id">)(.*?)(?=</FL>)').matcher(respBody);
        m.find();
        
        update new Contact(
            Id = contactId,
            ZohoId__c = m.group(1)
        );
    }    
    
    private static void logResponse(Id contactId, String operation, String reqUrl, HttpResponse resp) {
        if ((resp.getStatusCode() == SUCCESS_CODE && Zoho__c.getInstance().log_success__c) ||
           resp.getStatusCode() != SUCCESS_CODE) {
            insert new Zoho_Logs__c(
                Contact_Record_Id__c = contactId,
                Operation__c = operation,
                Request_URL__c = reqUrl,
                Status_Code__c = resp.getStatusCode(),
                Status_Message__c = resp.getBody()
            );
        }
    }
    
    private static void logError(Id contactId, String errMessage) {
        insert new Zoho_Logs__c(
            Contact_Record_Id__c = contactId,
            Status_Message__c = errMessage
        );        
    }

    class ZohoIntegrationException extends Exception {}
}
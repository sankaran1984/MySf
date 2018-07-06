public class StraticsUpdate {
    
    private static final String end_point = Stratics__c.getInstance().End_Point__c;
    private static final String api_key = Stratics__c.getInstance().api_key__c;
    private static final Boolean isSuccessLoggingEnabled = Stratics__c.getInstance().isLogSuccess__c;
    private static final String accountId = Stratics__c.getInstance().account_id__c;
    private static final String dnctype = Stratics__c.getInstance().dnc_type__c;
    private static final String reason = Stratics__c.getInstance().reason__c;
    private static final Integer MaxCallouts = 100;

    @future(callout=true)
    public static void fireAPI(Set<Id> leadIds) {
        
        // Get all Leads
        List<Lead> lsLeads = getLeads(leadIds);
        
        // Fire 100 call outs (max)
        Integer apiCallMax = lsLeads.size() > MaxCallouts ? MaxCallouts : lsLeads.size();
        List<Stratics_Logs__c> lsLogs = new List<Stratics_Logs__c>();
        for (Integer i = 0; i < apiCallMax; i++) {
        	sendRequest(lsLeads[i], lsLogs);    
        }
        
        if (!lsLogs.isEmpty()) insert lsLogs;
    }
    
    private static List<Lead> getLeads(Set<Id> leadIds) {
        return [Select Id, Phone From Lead Where Id IN :leadIds];
    }
    
    private static void sendRequest(Lead leadObj, List<Stratics_Logs__c> lsLogs) {
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(Test.isRunningTest() ? 'http://www.test.com' : end_point);
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{ ' +
        	'"webhook_key": "' + api_key + '",' +            
        	'"account_id": "' + accountId + '",' + 
            '"value": "' + leadObj.Phone + '",' +
            '"dnc_type": "' + dnctype + '",' +
            '"reason": "' + reason + '"' +        
        '}');
        HttpResponse resp = Test.isRunningTest() ? new HttpResponse() : new Http().send(req);
        
        logMessage(leadObj, req, resp, lsLogs);
    }

    private static void logMessage(Lead leadObj, HttpRequest req, HttpResponse resp, List<Stratics_Logs__c> lsLogs) {
        if (resp.getStatusCode() == 200 && !isSuccessLoggingEnabled) return;
        
        lsLogs.add(new Stratics_Logs__c(
            Lead__c = leadObj.Id,  
            Request_Sent__c = req.getBody(), 
            Is_Success__c = resp.getStatusCode() == 200, 
            Response_Message__c = resp.getStatusCode() + ' =' + resp.getBody()
        ));
    }
}
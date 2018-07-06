public class CreatePaymentsCtlr {
    
    // VF Bindings
    public Boolean loadFailed {get;set;}
    public List<Order__c> lsOrders {get;set;}
    public Map<Id, List<Payment__c>> mapOrderToPays {get;set;}

    public CreatePaymentsCtlr() {
        String orderIds = ApexPages.currentPage().getParameters().get('orderIds');
        if (String.isBlank(orderIds)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select atleast one Order to create payment'));
            loadFailed = True;
        }
        
        // Get Orders
        lsOrders = [
                Select 
                	Id, (Select Id, Payment_Type__c, Amount__c, Date__c, Other_Payment_Method__c, Refunded__c, Order__c From Payments__r),
            		Name, Outstanding_Amount__c
                From 
                	Order__c
                Where 
                	Id IN : orderIds.split(';')];
        
        // Create Dummy Payments, if not there
        mapOrderToPays = new Map<Id, List<Payment__c>>();
        for (Order__c o : lsOrders) {
            List<Payment__c> lsPays = new List<Payment__c>();
            lsPays.addAll(o.Payments__r);

            if (lsPays.isEmpty()) {
                //createPayment(o.Payments__r, o);
                lsPays.add(new Payment__c(
                    Payment_Type__c = 'Cash', 
                    Amount__c = o.Outstanding_Amount__c,  
                    Date__c = System.Today(), 
                    Other_Payment_Method__c = '', 
                    Refunded__c = False, 
                    Order__c = o.Id
                ));
                System.debug('lsPays - ' + lsPays);
            }
            mapOrderToPays.put(o.Id, lsPays);
        }
    }
    
    private void createPayment(List<Payment__c> lsPayments, Order__c o) {
        lsPayments.add(new Payment__c(
            Payment_Type__c = 'Cash', 
            Amount__c = o.Outstanding_Amount__c,  
            Date__c = System.Today(), 
            Other_Payment_Method__c = '', 
            Refunded__c = False, 
            Order__c = o.Id
        ));
    }
    
    public void save() {
        List<Payment__c> lsPaysToUpsert = new List<Payment__c>();
        for (List<Payment__c> lsPays : mapOrderToPays.values()) {
			lsPaysToUpsert.addAll(lsPays);
        }  
        
        if (!lsPaysToUpsert.isEmpty()) upsert lsPaysToUpsert;
    }
}
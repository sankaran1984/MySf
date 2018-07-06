trigger Zoho_ContactTrgr on Contact (after insert, after update) {
        
    if (System.isFuture()) return;

    // Only 50 Future calls allowed per transaction as of now
    // So, relax them if it's increased in future
    private final Integer FUTURE_MAX_LIMIT = 50;

    for (Integer count = 1; count <= Trigger.New.size(); count++) {
        Contact c = Trigger.New[count - 1];
        if (count == FUTURE_MAX_LIMIT) {
            c.addError('Max Future call limit reached. Retry saving these contacts');
            continue;
        }
        
        ZohoIntegration.pushContact(c.Id, Trigger.isInsert);
    }
}
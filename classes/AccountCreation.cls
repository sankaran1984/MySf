global class AccountCreation {

    webservice static String createAccount(String parentId, String recTypeName, String accName) {

        System.debug(parentId + ' test ' + recTypeName + ' ' +accName);
        
		if (String.isBlank(parentId)) {
            return 'Parent Account is missing';
        }

		System.debug('parentId - ' + parentId);        
        String recTypeId = Account.sObjectType.getDescribe().getRecordTypeInfosByName().get(recTypeName).getRecordTypeId();
        if (String.isBlank(recTypeId)) {
            return recTypeName + ' Record Type is invalid';
        }
        
        List<Account> lsAccs = [Select 
                             	BillingStreet,
                            	BillingCity,
                            	BillingState,
                            	BillingPostalCode,
                            	BillingCountry
                             From
                            	Account
                             Where
                            	Id =: ParentId];
        if (lsAccs.isEmpty()) return 'Parent Account doesn\'t exist';
        
        insert new Account(
            Name = accName,
            ParentId = parentId,
            RecordTypeId = recTypeId,
            BillingStreet = lsAccs[0].BillingStreet,
            BillingCity = lsAccs[0].BillingCity,
            BillingState = lsAccs[0].BillingState,
            BillingPostalCode = lsAccs[0].BillingPostalCode,
            BillingCountry = lsAccs[0].BillingCountry
        );
        
        return 'Success';
    }
}

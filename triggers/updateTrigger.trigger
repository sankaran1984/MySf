trigger updateTrigger on Merchandise__c (before update) {
	System.Debug('updateTrigger - static record-'+mystatic.m);
}
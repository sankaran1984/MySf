public with sharing class CommonUtils {

    public static String enforceSecurity(Boolean isInsert, Boolean isUpdate, Boolean isDelete, Boolean isUnDelete,
    		List<sObject> lsObjs) {
        if(lsObjs == Null || lsObjs.isEmpty()) return '';    
        
        if(isInsert && !lsObjs[0].getSObjectType().getDescribe().isCreateable()){
            return 'No Insert Permission for Record';
        } else if(isUpdate && !lsObjs[0].getSObjectType().getDescribe().isUpdateable()){
            return 'No Update Permission for Record';
        } else if(isDelete && !lsObjs[0].getSObjectType().getDescribe().isDeletable()){
			return 'No Delete Permission for Record';
        } else if(isUndelete && !lsObjs[0].getSObjectType().getDescribe().isUndeletable()){
            return 'No UnDelete Permission for Record';
        }
        
        Map<String, Object> mapFields = lsObjs[0].getPopulatedFieldsAsMap();
        Map<String, Schema.SObjectField> mapFieldResults = lsObjs[0].getSObjectType().getDescribe().fields.getMap(); 
        List<String> noPermFields = new List<String>();
                
        for (String fieldName : mapFields.keySet()) { 
            if(!mapFieldResults.get(fieldName).getDescribe().isPermissionable() || 
               		mapFieldResults.get(fieldName).getDescribe().isDefaultedOnCreate())
                continue;
            
            if (isInsert && !mapFieldResults.get(fieldName).getDescribe().isCreateable()) {
                noPermFields.add(fieldName);
            } else if(isUpdate && !mapFieldResults.get(fieldName).getDescribe().isUpdateable()) {
                noPermFields.add(fieldName);
            }
        }
        if (!noPermFields.isEmpty()) {
            return 'No Permission for ' + (isInsert ? 'insert' : 'update') + ' on ' +
                String.join(noPermFields, ',') + ' field' + (noPermFields.size() == 1 ? '' : 's');
        }        

        return '';
    }
}
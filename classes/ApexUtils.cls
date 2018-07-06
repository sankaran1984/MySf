Public Class ApexUtils {

    Public Static List<String> getAllFieldsForObject(String ObjName){
        If(ObjName==Null || String.isEmpty(ObjName)) return new List<String>();
        
        List<String> fieldList = new List<String>();
        fieldList.addAll(Schema.describeSObjects(new List<String>{ObjName})[0].fields.getMap().keySet());
        System.Debug('ApexUtils-getAllFieldsForObject-fieldList-'+fieldList);
        return fieldList;
    }
    
    Public Static Set<String> getAllAccessibleFields(String ObjName){
        If(ObjName==Null || String.isEmpty(ObjName)) return new Set<String>();
        
        Map<String, Schema.sObjectField> fieldMap = Schema.describeSObjects(new List<String>{ObjName})[0].fields.getMap();
        Set<String> accessibleFieldSet = new Set<String>();
        for(String fieldName: fieldMap.keySet()){
            if(fieldMap.get(fieldName).getDescribe().isAccessible())
                accessibleFieldSet.add(fieldName);
        }
        return accessibleFieldSet;
    }
    
    Public Static Set<String> getAllEditableFields(String ObjName){
        return Null;
    }
    
    Public Static Boolean isObjectCreatable(String ObjName){
        return True;
    }
    
    Public Static String getSfURL(){
        return URL.getSalesforceBaseURL().toExternalForm();
    }    
}
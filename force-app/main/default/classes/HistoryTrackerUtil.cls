public without sharing class HistoryTrackerUtil {
    
    public static List<sObject> getHistoryByObjectAndField(Id recordId, String fieldName){
        String objectName = recordId.getSobjectType().getDescribe().getName();
        String historyObjectName = objectName.replace('__c', '__History');
        //Add FLS
        List<sObject> historyList = Database.query('SELECT Id, ParentId, OldValue, NewValue, CreatedDate FROM '+historyObjectName.escapeHtml4()+' where Field = :fieldName and ParentId = :recordId ORDER BY CreatedDate Desc');
        return historyList;
    }
}
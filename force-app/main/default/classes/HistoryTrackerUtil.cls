public without sharing class HistoryTrackerUtil {
    
    public static List<ChangeHistory__b> getHistoryByObjectAndField(Id recordId, String fieldName){
    
        //Add FLS
        List<ChangeHistory__b> historyList = Database.query('SELECT  ParentId__c,OldValue__c, NewValue__c, Field__c,ChangedDate__c, CreatedById, CreatedDate FROM ChangeHistory__b WHERE ParentId__c=:recordId');
        return historyList;
    }
}
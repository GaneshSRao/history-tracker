public with sharing class HistoryTrackerController {
    
    @AuraEnabled(cacheable=true) 
    public static List<ChangeHistory__b> getHistory(String recordId) {
        List<ChangeHistory__b> result = HistoryTrackerUtil.getHistoryByObjectAndField(recordId, null);
        return result;
    }
}

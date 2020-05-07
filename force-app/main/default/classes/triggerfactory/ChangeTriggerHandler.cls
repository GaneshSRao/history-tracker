public with sharing class ChangeTriggerHandler implements ITriggerHandler {
  
    public void BeforeInsert(List<SObject> newItems) {}
 
    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {}
 
    public void BeforeDelete(Map<Id, SObject> oldItems) {}
 
    public void AfterInsert(Map<Id, SObject> newItems) {}
 
    public void afterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        String objectApi = String.valueOf(newItems.values().get(0).getSObjectType());
        //System.debug('**objectApi**'+objectApi);
        String objConfig = ChangeHistroySetupUtil.getConfigurationByObjectApi(objectApi);
        List<String> configFieldsList = objConfig.split(',');
        List<ChangeHistory__b> historyList = new List<ChangeHistory__b>();
        //System.debug('**objConfig**'+objConfig);
        for (SObject updatedRecord : newItems.values()) {
            SObject previousRecord = oldItems.get(updatedRecord.Id);
            //check for field changed
            for(String fieldApi : configFieldsList){
                if(updatedRecord.get(fieldApi) != previousRecord.get(fieldApi)){
                    //System.debug('**fieldApi**'+updatedRecord.get(fieldApi));
                    //create Hstory entry
                    ChangeHistory__b history = new ChangeHistory__b();
                    history.ParentId__c = updatedRecord.id;
                    history.Field__c = fieldApi;
                    history.NewValue__c = String.valueOf(updatedRecord.get(fieldApi));
                    history.OldValue__c = String.valueOf(previousRecord.get(fieldApi));
                    history.ChangedDate__c = DateTime.now();
                    historyList.add(history);
                }
            }
        }
        if(historyList.size()>0){
            ChangeHistoryInsertionHandler handler = new ChangeHistoryInsertionHandler(historyList);
            System.enqueueJob(handler);
        }
    }
 
    public void AfterDelete(Map<Id, SObject> oldItems) {}
 
    public void AfterUndelete(Map<Id, SObject> oldItems) {}
}

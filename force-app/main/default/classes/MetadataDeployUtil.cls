public with sharing class MetadataDeployUtil implements Metadata.DeployCallback {
  public static void deployMetadataCreate(
    String recordName,
    String objectApi,
    String trackedFields
  ) {
    Metadata.CustomMetadata configSetupRecord = new Metadata.CustomMetadata();
    configSetupRecord.fullName = 'Change_History_Configuration.' + recordName;
    configSetupRecord.label = recordName;
    setFieldValue(configSetupRecord, 'Object_API__c', objectApi);
    setFieldValue(configSetupRecord, 'Tracked_Fields__c', trackedFields);

    Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
    mdContainer.addMetadata(configSetupRecord);
    MetadataDeployUtil callback = new MetadataDeployUtil();
    if (!Test.isRunningTest()) {
      Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
    }
  }

  private static void setFieldValue(Metadata.CustomMetadata configSetupRecord,String fieldName,String fieldValue){
    if(configSetupRecord == null || String.isBlank(fieldName) || String.isBlank(fieldValue)){
      throw new MetaDataDeploymentFailureException();
    }
    Metadata.CustomMetadataValue configSetupField = new Metadata.CustomMetadataValue();
    configSetupField.field = fieldName;
    configSetupField.value = fieldValue; 
    configSetupRecord.values.add(configSetupField);
  }

  public void handleResult(
    Metadata.DeployResult result,
    Metadata.DeployCallbackContext context
  ) {
    if (result.status != Metadata.DeployStatus.Succeeded) {
      throw new MetaDataDeploymentFailureException(); 
    }
  }

}

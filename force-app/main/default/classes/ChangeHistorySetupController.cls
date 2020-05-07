public with sharing class ChangeHistorySetupController {
  @AuraEnabled(cacheable=true)
  public static List<ObjectWrapper> getObjectsList() {
    List<ObjectWrapper> sObjectList = new List<ObjectWrapper>();

    try {
      List<EntityDefinition> objectList = [
        SELECT QualifiedApiName, Label
        FROM EntityDefinition
        WHERE
          IsRetrieveable = true
          AND IsTriggerable = true
          AND IsQueryable = true
          AND IsEverUpdatable = true
          AND IsSearchable = true
          AND IsEverCreatable = true
          AND IsCustomSetting = false
          AND IsApexTriggerable = true
          AND QualifiedApiName NOT IN :ChangeHistroySetupUtil.retrieveUnsupportedObjects()
        ORDER BY Label ASC
      ];
      for (EntityDefinition entity : objectList) {
        sObjectList.add(
          new ObjectWrapper(entity.QualifiedApiName, entity.Label)
        );
      }
    } catch (Exception e) {
      System.debug(e.getMessage());
    }

    sObjectList.sort();
    return sObjectList;
  }

  @AuraEnabled(cacheable=true)
  public static List<FieldWrapper> getFieldsByObjectName(String objectApi) {
    List<FieldWrapper> fieldsList = new List<FieldWrapper>();

    Map<String, Schema.SObjectField> fieldDescribeMap = ChangeHistroySetupUtil.getFieldsDescribe(objectApi);

    String objConfig = ChangeHistroySetupUtil.getConfigurationByObjectApi(objectApi);

    List<String> configFieldsList = objConfig.split(',');

    if (!fieldDescribeMap.isEmpty()) {
      for (Schema.SObjectField field : fieldDescribeMap.values()) {
        fieldsList.add(
          new FieldWrapper(
            field.getDescribe().getLabel(),
            field.getDescribe().getName(),
            configFieldsList.contains(field.getDescribe().getName())?true:false
          )
        );
      }
    }
    fieldsList.sort();
    return fieldsList;
  }

  @AuraEnabled(cacheable=true)
  public static void createConfigRecord(String objectApi, String trackedFields){
      //save new
      //System.debug('***'+objectApi+'***'+trackedFields);
      MetadataDeployUtil.deployMetadataCreate(objectApi.replace('__','_'), objectApi, trackedFields);
  }

  public class ObjectWrapper implements Comparable {
    @AuraEnabled
    public String name { get; set; }
    @AuraEnabled
    public String label { get; set; }

    ObjectWrapper(String name, String label) {
      this.name = name;
      this.label = label;
    }
    public Integer compareTo(Object objCompareTo) {
      return label.compareTo(((ObjectWrapper) objCompareTo).label);
    }
  }

  public class FieldWrapper implements Comparable {
    @AuraEnabled
    public String label { get; set; }
    @AuraEnabled
    public String value { get; set; }
    @AuraEnabled
    public Boolean selected { get; set; }

    FieldWrapper(String label, String value, Boolean selected) {
      this.label = label;
      this.value = value;
      this.selected = selected;
    }
    public Integer compareTo(Object objCompareTo) {
      return label.compareTo(((FieldWrapper) objCompareTo).label);
    }
  }
}

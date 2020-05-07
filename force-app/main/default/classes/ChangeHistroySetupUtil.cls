public with sharing class ChangeHistroySetupUtil {
  public static Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();

  private final static Set<String> UNSUPPORTED_STANDARD_OBJECTS = new Set<String>{
    'AccountFeed',
    'AccountPartner',
    'AccountShare',
    'ActivityHistory',
    'CaseComment',
    'CollaborationGroup',
    'ContentVersion',
    'Document',
    'EntitySubscription',
    'FeedComment',
    'FeedItem',
    'Group',
    'Idea',
    'IdeaComment',
    'NewsFeed',
    'NoteAndAttachment',
    'Partner',
    'PermissionSet',
    'ProcessInstance',
    'ProcessInstanceHistory',
    'Solution',
    'Topic',
    'User',
    'UserProfileFeed',
    'UserRole'
  };

  private final static Set<String> UNSUPPORTED_CUSTOM_OBJECTS = new Set<String>{
    'Change_History_Config__c'
  };

  public static Set<String> retrieveUnsupportedObjects() {
    Set<String> unsupported = new Set<String>();

    unsupported.addAll(UNSUPPORTED_STANDARD_OBJECTS);
    unsupported.addAll(UNSUPPORTED_CUSTOM_OBJECTS);

    return unsupported;
  }

  public static Map<String, Schema.SObjectField> getFieldsDescribe(
    String selectedObject
  ) {
    return schemaMap.get(selectedObject).getDescribe().fields.getMap();
  }

  public static String getConfigurationByObjectApi(String selectedObject) {
    //fetch mdt
    if (
      !Schema.sObjectType.Change_History_Configuration__mdt.fields.Tracked_Fields__c.isAccessible()
    ) {
      return '';
    }
    String objConfig = '';
    List<Change_History_Configuration__mdt> configList = [
      SELECT id, Tracked_Fields__c
      FROM Change_History_Configuration__mdt
      WHERE Object_API__c = :selectedObject
    ];
    if(configList.size()>0){
      objConfig = configList.get(0).Tracked_Fields__c;
    }
    return objConfig;
  }
  
}

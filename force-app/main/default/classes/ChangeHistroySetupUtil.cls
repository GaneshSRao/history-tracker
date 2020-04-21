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
}

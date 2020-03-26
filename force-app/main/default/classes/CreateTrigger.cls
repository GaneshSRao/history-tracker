public with sharing class CreateTrigger {
  public static String triggerBody = '';

  public static void createAutoTrigger(String selectedObject) {
    String triggerJson = '';

    triggerJson = createJsonString(String.escapeSingleQuotes(selectedObject));
    String url =
      System.Url.getSalesforceBaseUrl().toExternalForm() +
      '/services/data/v48.0/sobjects/ApexTrigger';

    sendRequest(triggerJson, url);
  }

  /*
   Description : Create Json String for creation of trigger.
   
   */
  public static String createJsonString(String objectApiName) {
    String selectedObjName = getTriggerName(objectApiName);
    String apiVersion = Json.serialize('48.0');
    //String Body = Json.serialize('trigger '+selectedObjName+' on '+objectApiName+ ' (before update,before delete,after delete,after insert,after update){CMPL123.AuditHandler.handleAudit(new CMPL123.AuditTrigger(Trigger.isDelete, Trigger.isInsert,Trigger.isUpdate,Trigger.isAfter,Trigger.isBefore,Trigger.size,Trigger.old,Trigger.new,Trigger.oldMap,Trigger.newMap));}');
    String commentOnTrigger = '/************************* This is karthickeyan Creteated Trigger ****************************/\n';
    String body = Json.serialize(
      commentOnTrigger +
      'trigger ' +
      selectedObjName +
      ' on ' +
      objectApiName +
      ' (before insert,after insert,before update,after update,before delete,after delete,after undelete){' +
      triggerBody +
      '}'
    );
    String lengthWithoutComments = Json.serialize('10');
    String name = Json.serialize(selectedObjName + '_AuditTrigger');
    String status = Json.serialize('Active');
    String tableEnumOrId = Json.serialize(objectApiName);
    String usageAfterDelete = Json.serialize('false');
    String usageAfterInsert = Json.serialize('false');
    String usageAfterUndelete = Json.serialize('false');
    String usageAfterUpdate = Json.serialize('false');
    String usageBeforeDelete = Json.serialize('false');
    String usageBeforeInsert = Json.serialize('true');
    String usageBeforeUpdate = Json.serialize('true');
    String usageIsBulk = Json.serialize('false');
    String finalJson =
      '{"ApiVersion":' +
      apiVersion +
      ',"Body":' +
      body +
      ',"LengthWithoutComments":' +
      lengthWithoutComments +
      ',"Name":' +
      name +
      ',"Status":' +
      status +
      ',"TableEnumOrId":' +
      tableEnumOrId +
      ',"UsageAfterDelete":' +
      usageAfterDelete +
      ',"UsageAfterInsert":' +
      usageAfterInsert +
      ',"UsageAfterUndelete":' +
      usageAfterUndelete +
      ',"UsageAfterUpdate":' +
      usageAfterUpdate +
      ',"UsageBeforeDelete":' +
      UsageBeforeDelete +
      ',"UsageBeforeInsert":' +
      usageBeforeInsert +
      ',"UsageBeforeUpdate":' +
      usageBeforeUpdate +
      ',"UsageIsBulk":' +
      usageIsBulk +
      '}';
    // System.debug('------finalJson ----'+finalJson );
    return finalJson;
  }

  public static String getTriggerName(String objectApiName) {
    String selectedObjName;
    if (objectApiName.contains('__')) {
      selectedObjName = objectApiName.countMatches('__') == 2
        ? objectApiName.substringBefore('__') +
          '_' +
          objectApiName.substringBetween('__')
        : objectApiName.substringBefore('__');
    } else {
      selectedObjName = objectApiName;
    }
    // System.debug('----selectedObjName---'+selectedObjName);
    return selectedObjName + '_' + 'ChangeHistoryTrigger';
  }

  public static void sendRequest(String finaljson, String url) {
    Http htp = new Http();
    HttpRequest req = new HttpRequest();
    req.setMethod('POST');
    req.setEndpoint(url);
    req.setHeader('Content-type', 'application/json');
    req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
    req.setBody(finaljson);
    String respBody;
    //if(Test.isRunningTest() == false){
    HttpResponse res = htp.send(req);
    respBody = res.getBody();
    //}
  }
}

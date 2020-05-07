public with sharing class TriggerDispatcher {
  public static void run(ITriggerHandler handler) {

    // Detect the current trigger context and fire the relevant methods on the trigger handler:
    
    // Before trigger logic

    if (Trigger.IsBefore && Trigger.IsInsert) {
      handler.beforeInsert(Trigger.new);
    }

    if (Trigger.IsBefore && Trigger.IsUpdate) {
      handler.beforeUpdate(Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.IsBefore && Trigger.IsDelete) {
      handler.beforeDelete(Trigger.oldMap);
    }

    // After trigger logic

    if (Trigger.IsAfter && Trigger.IsInsert) {
      handler.afterInsert(Trigger.newMap);
    }

    if (Trigger.IsAfter && Trigger.IsUpdate) {
      handler.afterUpdate(Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.IsAfter && Trigger.IsDelete) {
      handler.afterDelete(Trigger.oldMap);
    }

    if (Trigger.IsAfter && Trigger.isUndelete) {
      handler.afterUndelete(Trigger.oldMap);
    }
  }
}

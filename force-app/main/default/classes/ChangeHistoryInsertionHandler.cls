public with sharing class ChangeHistoryInsertionHandler implements Queueable {
  private List<ChangeHistory__b> histories;

  public ChangeHistoryInsertionHandler(List<ChangeHistory__b> histories) {
    this.histories = histories;
  }

   public void execute(QueueableContext context) {
    try {
      // We have to use insertImmediate() to insert big object records.
      List<Database.SaveResult> srList = Database.insertImmediate(histories);
    } catch (Exception e) {
      System.debug('Exception: ' + e.getTypeName() + ', ' + e.getMessage());
    }
   }
}

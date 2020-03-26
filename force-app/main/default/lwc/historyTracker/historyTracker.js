import { LightningElement, track, api, wire } from "lwc";
import getHistory from "@salesforce/apex/HistoryTrackerController.getHistory";

const columns = [
  { label: "Field", fieldName: "Field__c" },
  { label: "Old Value", fieldName: "OldValue__c" },
  { label: "New Value", fieldName: "NewValue__c" },
  {
    label: "Date",
    fieldName: "CreatedDate",
    type: "date",
    typeAttributes: {
      year: "numeric",
      month: "long",
      day: "2-digit",
      hour: "2-digit",
      minute: "2-digit"
    }
  },
  { label: "User", fieldName: "CreatedById" }
];

export default class HistoryTracker extends LightningElement {
  @api recordId;
  @track data = [];
  @track columns = columns;

  @wire(getHistory, { recordId: "$recordId" })
  histories;
}

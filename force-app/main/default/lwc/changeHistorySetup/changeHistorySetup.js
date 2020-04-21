import { LightningElement, track, wire } from "lwc";
import getObjectsList from "@salesforce/apex/ChangeHistorySetupController.getObjectsList";

// const objects2 = [
//   { label: "Account", name: "Account" },
//   { label: "Contact", name: "Contact" },
//   { label: "Opportunity", name: "Opportunity" },
//   { label: "Quote", name: "Quote" },
//   { label: "Product", name: "Product" },
//   { label: "Campaign", name: "Campaign" },
//   { label: "Lead", name: "Lead" },
//   { label: "Case", name: "Case" },
//   { label: "Knowledge", name: "Knowledge" },
//   { label: "Asset", name: "Asset" },
//   { label: "Contract", name: "Contract" },
//   { label: "Order", name: "Order" },
//   { label: "Student", name: "Student__c" },
//   { label: "Candidate", name: "Candidate__c" },
//   { label: "Account", name: "Account2" },
//   { label: "Contact", name: "Contact2" },
//   { label: "Opportynity", name: "Opportynity2" },
//   { label: "Quote", name: "Quote2" },
//   { label: "Product", name: "Product2" },
//   { label: "Campaign", name: "Campaign2" },
//   { label: "Lead", name: "Lead2" },
//   { label: "Case", name: "Case2" },
//   { label: "Knowledge", name: "Knowledge2" },
//   { label: "Asset", name: "Asset2" },
//   { label: "Contract", name: "Contract2" },
//   { label: "Order", name: "Order2" },
//   { label: "Student", name: "Student2__c" },
//   { label: "Candidate", name: "Candidate2__c" }
// ];

export default class ChangeHistorySetup extends LightningElement {
  // @track objects = objects;
  @wire(getObjectsList)
  objects;

  @track selectedItem = 'Account';
  @track currentContent = '';

  handleSelect(event) {
    this.currentContent = event.detail.name;
  }
}

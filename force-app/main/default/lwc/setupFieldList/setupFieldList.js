import { LightningElement, api, wire } from 'lwc';
import getFieldsByObjectName from '@salesforce/apex/ChangeHistorySetupController.getFieldsByObjectName';

// const options = [
//     { label: 'Account Name', value: 'AccountId' , selected:true},
//     { label: 'Amount', value: 'Amount' ,selected:true},
//     { label: 'Close Date', value: 'CloseDate' ,selected:true},
//     { label: 'Contract', value: 'ContractId' ,selected:false},
//     { label: 'Created By', value: 'CreatedById' ,selected:false},
//     { label: 'Forecast Category Name', value: 'ForecastCategoryName' ,selected:true},
//     { label: 'Last Modified By', value: 'LastModifiedById' ,selected:false},
//     { label: 'Lead Source', value: 'LeadSource' ,selected:false},
//     { label: 'Next Step', value: 'NextStep' ,selected:false},
//     { label: 'Opportunity Name', value: 'OpportunityName' ,selected:false},
//     { label: 'Opportunity Owner', value: 'OpportunityOwner' ,selected:false},
//     { label: 'Primary Campaign Source', value: 'CampaignSource' ,selected:false},
//     { label: 'Probability', value: 'Probability' ,selected:false},
//     { label: 'Score', value: 'Score__c' ,selected:false},
//     { label: 'Stage', value: 'Stage' ,selected:false},
//     { label: 'Type', value: 'Type' ,selected:false},
//     { label: 'Description', value: 'Description' ,selected:false},
// ];

export default class App extends LightningElement {

    @api objectapi;
    @wire(getFieldsByObjectName, {objectApi:"$objectapi"})
    options;
    // @track options = options; 

    clickHandler(e){
        alert(e.target.value + e.target.checked);
    }
}
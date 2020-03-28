import { LightningElement, track } from 'lwc';

const options = [
    { label: 'Account Name', value: 'AccountId' },
    { label: 'Amount', value: 'Amount' },
    { label: 'Close Date', value: 'CloseDate' },
    { label: 'Contract', value: 'ContractId' },
    { label: 'Created By', value: 'CreatedById' },
    { label: 'Forecast Category Name', value: 'ForecastCategoryName' },
    { label: 'Last Modified By', value: 'LastModifiedById' },
    { label: 'LeadS ource', value: 'LeadSource' },
    { label: 'Next Step', value: 'NextStep' },
    { label: 'Opportunity Name', value: 'OpportunityName' },
    { label: 'Opportunity Owner', value: 'OpportunityOwner' },
    { label: 'Primary Campaign Source', value: 'CampaignSource' },
    { label: 'Probability', value: 'Probability' },
    { label: 'Score', value: 'Score' },
    { label: 'Stage', value: 'Stage' },
    { label: 'Type', value: 'Type' },
    { label: 'Description', value: 'Description' },
];

export default class SetupFieldList extends LightningElement {
    @track value = [];
    @track options = options;

    get selectedValues() {
        return this.value.join(',');
    }

    handleChange(e) {
        this.value = e.detail.value;
    }
}
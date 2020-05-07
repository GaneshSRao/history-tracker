import { LightningElement, track, api, wire } from "lwc";
import getFieldsByObjectName from "@salesforce/apex/ChangeHistorySetupController.getFieldsByObjectName";
import createConfigRecord from "@salesforce/apex/ChangeHistorySetupController.createConfigRecord";
import { refreshApex } from "@salesforce/apex";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SetupFieldList extends LightningElement {
  @api 
  get objectapi(){
    return this._objectapi;
  }
  set objectapi(value){
      this.isloading = true;
      this._objectapi = value;
  }

  @api objectname;
  
  @track disableRefresh = false;
  @track optionsList;
  @track isloading = true;
  
  _objectapi;

  /** Wired Apex result so it can be refreshed programmatically */
  originalList;

  @wire(getFieldsByObjectName, { objectApi: "$objectapi" })
  options(result) {
    this.originalList = result;
    if (result.data) {
      this.optionsList = result.data;
      this.isloading = false;
    } else if (result.error) {
      this.error = result.error;
    }
  }

  clickHandler(e) {
    // alert(e.target.value + e.target.checked);
    this.disableRefresh = false;
    const temp = this.optionsList.map(obj => {
      if (obj.value === e.target.value) {
        obj = { ...obj, selected: e.target.checked };
        // console.log(obj);
      }
      return obj;
    });
    // console.log(temp);
    this.optionsList = temp;
  }

  handleSave() {
    // return refreshApex();
    const temp = this.optionsList.filter(obj => {
      return obj.selected === true;
    });

    const trackedFields = temp.map(a => a.value).toString();
    //alert(trackedFields);
    createConfigRecord({
      objectApi: this.objectapi,
      trackedFields: trackedFields
    })
      .then(() => {
        //alert(result);
        this.disableRefresh = true;
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: this.objectname+' Configuration Updated Successfully',
                variant: 'success'
            })
        );
        return refreshApex(this.originalList);
      })
      .catch(error => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'Configuration Updation Failed',
                variant: 'error'
            })
        );
        this.error = error;
      });
  }

  handleRefresh() {
    this.disableRefresh = true;
    this.optionsList =
      this.originalList && this.originalList.data
        ? this.originalList.data
        : this.optionsList;
  }
}

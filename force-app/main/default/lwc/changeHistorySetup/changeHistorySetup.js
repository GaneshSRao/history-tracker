import { LightningElement, track, wire } from "lwc";
import getObjectsList from "@salesforce/apex/ChangeHistorySetupController.getObjectsList";

export default class ChangeHistorySetup extends LightningElement {
  // @track objects = objects;
  @wire(getObjectsList)
  objects;

  @track selectedItem = 'Account';
  @track currentobjectLabel = 'Account';
  @track currentObjectApi = 'Account';

  handleSelect(event) {
    this.currentObjectApi = event.detail.name;
    // extract selected object name
    if(this.objects.data){
      const currentobjects = this.objects.data.filter(obj => {
        return obj.name === this.currentObjectApi;
      });
      this.currentobjectLabel = currentobjects[0].label;
    }
  }
}

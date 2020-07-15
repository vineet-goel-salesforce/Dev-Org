import { LightningElement, api, wire } from "lwc";
import searchContacts from "@salesforce/apex/SearchContactsController.searchContacts";
const DELAY = 300;
export default class RelatedContacts extends LightningElement {
  @api
  recordId;
  searchKey = "";

  @wire(searchContacts, { searchString: "$searchKey", accId: "$recordId" })
  contacts;

  handlechange(event) {
    // Debouncing this method: Do not update the reactive property as long as this function is
    // being called within a delay of DELAY. This is to avoid a very large number of Apex method calls.
    window.clearTimeout(this.delayTimeout);
    const searchKey = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.searchKey = searchKey;
    }, DELAY);
  }
}
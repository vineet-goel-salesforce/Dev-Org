import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
export default class FetchContacts extends LightningElement {
    @wire (getContactList) contacts;
    
}
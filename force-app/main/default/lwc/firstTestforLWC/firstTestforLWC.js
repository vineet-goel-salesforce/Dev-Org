import { LightningElement, api, wire } from "lwc";
//@Salesforce/apex/namespace.controller.controllermethod
import getgreetingMessage from "@salesforce/apex/classforLWC.getgreetingMessage";
export default class HelloWorld extends LightningElement {
  @api greeting;
  @api recordId;
  @wire(getgreetingMessage, { a: "$recordId" }) testgreeting({ data }) {
    if (data) {
      this.greeting = data;
    }
  }
}

//@wire(getgreetingMessage, )
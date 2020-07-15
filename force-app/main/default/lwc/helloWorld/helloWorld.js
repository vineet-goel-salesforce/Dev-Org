import { LightningElement, api } from 'lwc';
export default class HelloWorld extends LightningElement {
  @api greeting = 'World';
  changeHandler(event) {
    this.greeting = event.target.value;
  }
}
import { LightningElement,api } from 'lwc';

export default class Hellovineeet extends LightningElement {
    @api greeting ;
    onhandlechange(event){
        this.greeting = event.target.value;
    }
}
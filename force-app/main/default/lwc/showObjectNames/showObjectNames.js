import { LightningElement, track, wire } from 'lwc';
import getObjectNamesFromCache from '@salesforce/apex/ObjectNameController.objectNamesFromCache';
//import getObjectNamesbyCacheBuilderInterface from '@salesforce/apex/ObjectNameController.objectNamesbyCacheBuilderInterface';
//import getObjectNamesbySOQL from '@salesforce/apex/ObjectNameController.objectNamesbySOQL';

export default class ShowObjectNames extends LightningElement {
    @track objectNames;
    @track selectedObj;
    @wire(getObjectNamesFromCache) wiredObjectNames({error, data}){
        if(data){
            this.objectNames = data;
            this.error = undefined;
        } else if(error){
            this.error= error;
            this.objectNames = undefined;
        }
    }

    handleonChange(event){
        this.selectedObj = event.target.value;
        console.log(this.selectedObj);
    }
}
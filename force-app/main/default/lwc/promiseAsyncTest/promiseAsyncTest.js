import { LightningElement } from 'lwc';

export default class PromiseAsyncTest extends LightningElement {
    var1;
    var2;

    var1Change(event){
        this.var1 = event.target.value;
    }

    var2Change(event){
        this.var2 = event.target.value;
    }

    testPromise(){
        this.promiseDemo(this.var1, this.var2)
            .then((result) => {
                console.log(result);
                    alert("Resolved");
            })
            .catch((result) =>{
                console.log(result);
                alert("Rejected");
            })
    }

    promiseDemo(v1,v2){
        return new Promise ((resolve,reject) =>{
            if(v1 == v2) {
                resolve();
            }else{
                reject();
            }
        })
    }

    async asyncDemo() {
        await this.testPromise();
        return 'This is AsyncDemo';
    }
    testAsync(){
        this.asyncDemo()
            .then((result) =>{
                alert(result);
            })
    }
}
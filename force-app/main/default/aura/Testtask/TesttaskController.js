({
    doInit : function(component, event, helper) {
        var action = component.get("c.initTask");
        action.setParams({ 
            "contactId": '0032800000vdmgT' // test id
        });
        
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                var record 		= a.getReturnValue();
                console.log("record = ");
                console.log(record);
                console.log(record.Type);
                
                if(record.Type == '') {
                    console.log('Type is empty');
                } else {
                    console.log('Type is something else?');
                }
                console.log(a.getReturnValue().Type)
                
               component.set('v.record', record);
                console.log('post set');
               console.log(component.get('v.record').Type);
            } else if (state === "ERROR") {
                var errors = a.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);
    }
})
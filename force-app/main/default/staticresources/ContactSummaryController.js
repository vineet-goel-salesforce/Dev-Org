({
    doInit : function(component, event) {
        var conId = component.get("v.contactId");
        var action = component.get("c.findContactById");
        action.setParams({
            "contactId": conId
        });        
        action.setCallback(this, function(response) {
            var state = response.getState();
            
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.contact", response.getReturnValue());
            }
            else if (component.isValid() && state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        $A.error("Error message is: " +
                                 errors[0].message);
                    }
                } else {
                    $A.error("Unknown error is:");
                }
            }            
            
        });
        $A.enqueueAction(action);
    }
    
})
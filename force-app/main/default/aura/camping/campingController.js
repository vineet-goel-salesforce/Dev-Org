({
    logArray : function(component, event, helper) {
        var items = component.get("v.items");
        console.log(JSON.stringify(items));
    },
    doInit: function(component, event, helper) {
        var action = component.get("c.getItems");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    }
})
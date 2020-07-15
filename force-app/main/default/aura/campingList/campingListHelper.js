({
    createItem : function(component, item) {
        var action = component.get("c.saveItem");

            //var newItem = component.get("v.newItem");
            action.setParams({
                "item": item
            });

            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    var items = component.get("v.items");
                    items.push(response.getReturnValue());
                    item = {sobjectType: "Camping_Item__c"};;
                    component.set("v.newItem", item);
                    component.set("v.items", items);
                }
            });

            $A.enqueueAction(action);
    }
})
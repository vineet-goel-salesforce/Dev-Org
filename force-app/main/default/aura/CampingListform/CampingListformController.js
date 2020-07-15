({
    clickCreateItem : function(component, event, helper) {
        var isValidItem = component.find('campingItemForm').reduce(function(total,currentValue, index,arr)
                                                 {
                                                               currentValue.showHelpMessageIfInvalid();
                                                               return total && currentValue.get('v.validity').valid;
                                                           }, true);
        if(isValidItem) {
            helper.createItem(component);
        }
    }
})
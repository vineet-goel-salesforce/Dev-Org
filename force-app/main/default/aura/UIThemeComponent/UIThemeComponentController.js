({
    openSubTabClick : function(component, event, helper) {
        var recordId = component.get("v.recordId");
        var objectName = component.get("v.sObjectName");
        
        	component.set("v.url", "/apex/UIThemeCheckPage");
            console.log(component.get("v.url"));
    },
    dismissIt : function(component, event, helper) {
        var wasDismissed = $A.get("e.force:closeQuickAction").fire(); 
        $A.get('e.force:refreshView').fire();
    },    
})
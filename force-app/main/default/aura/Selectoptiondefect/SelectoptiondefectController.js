({
	doInit : function(component, event, helper) {
        var contactListAction = component.get("c.getContacts");
        contactListAction.setParams({
            "recordId": component.get("v.recordId")
        });
        contactListAction.setCallback(this,
                                      function(response){
                                          var state = response.getState();
                                          if (state.toUpperCase() === 'SUCCESS'){                               
                                              component.set("v.contactList", response.getReturnValue());                                                                                        
                                          }else{
                                              alert('Unable to get list of Contacts');
                                          } 
                                      }
                                     );
        $A.enqueueAction(contactListAction);
        var colorList = ['red'];
        component.set("v.colorList", colorList);
        
        var colorListTwo = ['yellow','red'];
        component.set("v.colorListTwo", colorListTwo);
	},
    
    onSelectChange : function(component, event, helper) {
    var selected = component.find("colorSelection").get("v.value");
    //do something else
},
    selectionMade : function (component, event, helper){  
        var message = 'Selected Animal: ' + component.find("animalSelection").get("v.value");
        message += '\nSelected Single Color: ' + component.find("colorSelection").get("v.value");
        message += '\nSelected Multiple Color: ' + component.find("mcolorSelection").get("v.value");
        message += '\nSelected Contact: ' + component.find("contactSelection").get("v.value");
        alert(message);
        //var selectedColorValue = component.find("colorSelection").get("v.value");
        //alert('Selected Color: ' + selectedColorValue);
        
        //var selectedContactValue = component.find("contactSelection").get("v.value");
        //alert('Selected Contact: ' + selectedContactValue);
               
    }
})
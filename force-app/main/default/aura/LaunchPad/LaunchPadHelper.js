({
	setEnabledCSS: function(component, componentId)
    { 
        //- Set component class value
        var modal = component.find(componentId); 
        $A.util.removeClass(modal, 'disabled'); 
        $A.util.addClass(modal, 'enabled'); 
    },
    
    setDisabledCSS: function(component, componentId)
    { 
        var modal = component.find(componentId); 
        $A.util.removeClass(modal, 'enabled'); 
        $A.util.addClass(modal, 'disabled');
    },
    
    showPopupHelper: function(component, componentId, className)
    { 
        var modal = component.find(componentId); 
        $A.util.removeClass(modal, className+'hide'); 
        $A.util.addClass(modal, className+'open'); 
    },
    
    hidePopupHelper: function(component, componentId, className)
    { 
        //- Hide dialog window
        var modal = component.find(componentId); 
        $A.util.addClass(modal, className+'hide'); 
        $A.util.removeClass(modal, className+'open'); 
        //component.set('v.body', ''); 
        //- Clear any selections made
        var selectedContact = component.find('contactSelection');
        selectedContact.set('v.value','');
        component.set("{!v.newCaseSelected}",false);
        var selectedCase = component.find('caseSelection');
        selectedCase.set('v.value','Select');
    }
})
({
	doInit : function(component, event, helper) {
		//- Set component attributes based on Apex Controller values
		//- Determine if on Do Not Call
		var dncAction = component.get("c.isDoNotCall");
        dncAction.setParams({
            "recordId": component.get("v.recordId")
        });
        dncAction.setCallback(this,
        	function(response){                
                var responseState = response.getState();
                if (responseState.toUpperCase() === 'SUCCESS'){
                    component.set("v.disableLaunch",response.getReturnValue());        
                    //- Pausing in order to make sure component has been properly loaded before trying to continue
                    //- Without this, sometimes the buttons would enable and other times they wouldn't
                    setTimeout(function(){  
                        //- Set Launch Button CSS based on Disable Launch value
                    	if (component.get("v.disableLaunch")){                    
                            //- Set CSS to disabled
                            helper.setDisabledCSS(component,"WinFlex");
                            helper.setDisabledCSS(component,"iGo");
                        }else{                                        
                            //- Set CSS to enabled                    
                            helper.setEnabledCSS(component,"WinFlex");
                            helper.setEnabledCSS(component,"iGo");
                            
                            //- If Contact List is allowed - load Contact List
                            if (component.get("v.allowContactList")){
                                var contactListAction = component.get("c.getContacts");
                                contactListAction.setParams({
                                    "recordId": component.get("v.recordId")
                                });
                                contactListAction.setCallback(this,
                                	function(response){
                                        var state = response.getState();
                                        if (state.toUpperCase() === 'SUCCESS'){                               
                                            component.set("v.contactList", response.getReturnValue());
                                           
                                            //component.set("v.hasContacts",response.getReturnValue().length > 0)                                            
                                        }else{
                                            alert('Unable to get list of Contacts');
                                        } 
                                    }
                                );
                                $A.enqueueAction(contactListAction);
                            }
                        }
                    },1000);                                        
                }else{
                    alert("Problem occurred when retrieving Do Not Call status");
                }
            }
        );
        $A.enqueueAction(dncAction);        
	},
    
    showDialog : function(component, event, helper) {
        var buttonName = event.getSource().getLocalId();
        component.set('{!v.selectedProvider}',buttonName);
        //alert('Button Name: ' + buttonName);
        //component.set('{!v.dynamicContent}','dyncamic Content');
		helper.showPopupHelper(component, 'modaldialog', 'slds-fade-in-'); 
        helper.showPopupHelper(component, 'backdrop', 'slds-backdrop--');
	},
    
    hideDialog : function(component, event, helper) {        
    	helper.hidePopupHelper(component, 'modaldialog', 'slds-fade-in-');
        helper.hidePopupHelper(component, 'backdrop', 'slds-backdrop--');
	},
    
    caseSelectionChanged: function(component, event, helper){
    	var selectedCase = component.find("caseSelection");
        if (selectedCase != null){
            var selectedCaseValue = selectedCase.get("v.value");
            if (selectedCaseValue.length > 0){                
                if (selectedCaseValue.toUpperCase() == 'NEW'){
                    //- Enable Contact Selection 
                    component.set("{!v.newCaseSelected}",true);                      
                }else{
                    //- Disable Contact Selection                    
                    component.set("{!v.newCaseSelected}",false);                    
                }
            }
        }
    },
    
    selectionMade : function (component, event, helper){   
        //- First get value of Cases b/c that will determine if we need Contact or not
        var selectedProvider = component.get("{!v.selectedProvider}");        
        var selectedCase = component.find("caseSelection");
        var selectedCaseValue = selectedCase.get("v.value");
        var selectedContactValue = '';
        var selectedValues = '';
        if (selectedCaseValue.length > 0 && selectedCaseValue.toUpperCase() != 'SELECT'){
            var okayToHide = false;
            if (selectedCaseValue.toUpperCase() == "NEW"){
                //- If Contact List allowed and New is selected - Get selected Contact
                if (component.get("v.allowContactList")){
                  
                    //- User chose to start a new case so make sure we have a contact selected
                    var selectedContact = component.find("contactSelection");  
                    alert('Contact 1 ' +selectedContact.get("v.value"));
                    if (selectedContact.get("v.value") != undefined){
                    	selectedContactValue = selectedContact.get("v.value");
                        alert('Contact Details  ' +selectedContactValue);
                    }                    
                }else{
                    //- Use the recordId - this will be either the LeadId or ContactId if on those detail pages
                    selectedContactValue = component.get("v.recordId");
                     alert('Contact Details 1 ' +selectedContactValue);
                }
                if (selectedContactValue.length > 0){                                       
                    okayToHide = true;                    
                }else{
                     alert('Contact Details 2 ' +selectedContactValue);
                    alert('Please select a Contact');
                } 
            }else{
                okayToHide = true;
            }
            
            if (okayToHide){
                //- Save user selected values in prep for jump to provider                
				var saveSAMLData = component.get("c.SaveSAMLData");       
                saveSAMLData.setParams({
                    "landingPage": selectedCaseValue
                   ,"objectID": selectedContactValue
                   ,"serviceProviderName": selectedProvider
                });
                saveSAMLData.setCallback(this,
                function(response){
                    //alert('Jump to Service Provider will occur at this point\n\rCase Type: ' + selectedCaseValue + "\n\rSalesforce ID: " + selectedContactValue);                    
                    var saveSAMLResult = response.getReturnValue();
                    if (saveSAMLResult != null && saveSAMLResult.length > 0){
                        var idpURL = saveSAMLResult[0];
                        var error = saveSAMLResult[1];
                        if (error.length == 0){
                            if (idpURL != null && idpURL.length > 0){                                  
                                //- Use the urlEvent b/c window.open causes IE to throw exception when it attempts to execute the setTimeout
                                var urlEvent = $A.get("e.force:navigateToURL");
                                urlEvent.setParams({
                                  "url": idpURL
                                });
                                urlEvent.fire(); 
                                
                                //- Use the setTimeout call in order to give jump to service provider time to complete
                                setTimeout(function(){                            
                                    var cleariGoSAMLData = component.get("c.ClearSAMLData");
                                    cleariGoSAMLData.setCallback(this,function(response){});
                                    $A.enqueueAction(cleariGoSAMLData);                             
                                },6000);
                    
                			}else{alert(selectedProvider + ' URL was not found');}
                            
                         alert('provider'+selectedProvider);
                        }else{alert('Error: ' + error);}
                    }else{ alert('Proper results were not detected');}                     
                });
                $A.enqueueAction(saveSAMLData); 
                
                helper.hidePopupHelper(component, 'modaldialog', 'slds-fade-in-');
                helper.hidePopupHelper(component, 'backdrop', 'slds-backdrop--'); 
              }
        }else{
            alert('Please select a Case Type');
        }     	
    }
})
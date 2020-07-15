public with sharing class LaunchPadController{
    @AuraEnabled
    public static List<string> SaveSAMLData(string landingPage, string objectID,string serviceProviderName){              
    return SAMLDataHelper.SaveSAMLData(UserInfo.getUserId(), landingPage, objectID, serviceProviderName);
    }
    
    @AuraEnabled
    public static void ClearSAMLData(){
        SAMLDataHelper.ClearSAMLData(UserInfo.getUserId());
    }
    
    @AuraEnabled
    public static boolean isDoNotCall(Id recordId) {
        //- Updated to support Lead and Contact ID values       
        boolean doNotCallValue = false;
        if (recordId != null){
           if (EnumContainer.GetObjectType(recordId) == EnumContainer.ObjectType.ISLEAD){
                //- We have an Lead ID
                Lead lead = [Select DoNotCall From Lead where ID = :recordId];
                doNotCallValue = lead.DoNotCall;
            }
            
           if (EnumContainer.GetObjectType(recordId) == EnumContainer.ObjectType.ISCONTACT)
        {
                //- We have a Contact ID
                Contact contact = [Select DoNotCall From Contact where ID = :recordId];
                doNotCallValue = contact.DoNotCall;
            }           
            
            if (EnumContainer.GetObjectType(recordId) == EnumContainer.ObjectType.ISOPPORTUNITY)
        {
                List<Contact> contacts = LaunchPadController.getContacts(recordId);               
                if (contacts.size() == 0){                  
                    //- Either no contacts are associated with this opportunity/account OR all are marked as Do Not Call
                    doNotCallValue = true;
                }
            }           
        }
        return doNotCallValue;
}
    
    @AuraEnabled
    public static List<Contact> getContacts(string recordId){              
       List<Contact> contacts = null;
       
       //- This controller will primarily be used from Opportunity Detail page
       //- b/c it is only spot that we may or may not know exactly which Contact info to include in launch
       //- So, we must provide user with list of contacts (0 to many) that they can pick one from when they launch to iGo or WinFlex
       //- Only provide Contacts that are not marked as Do Not Call
       
       //- First attempt to pull list based on Contact Role
       List<OpportunityContactRole> contactRoles = [Select Id, ContactId from OpportunityContactRole where OpportunityId = :recordId];
       List<Id> contactIds = new List<Id>();
       for(OpportunityContactRole contactRole : contactRoles){
            contactIds.add(contactRole.ContactId);
       }
       if (contactIds.size() > 0){
            contacts = [Select Id, Name, DoNotCall From Contact where Id in :contactIds];
       }       
       
       //- If no contacts found from Contact Roles - look to the Account that the Opportunity is associated with       
       if (contacts == null || contacts.size() == 0){
            Opportunity opp = [Select ID, AccountId From Opportunity where Id = :recordId];
            contacts = [Select Id, Name, DoNotCall From Contact where AccountId = :opp.AccountId];              
       }
       
       if (contacts != null){
           //- Remove any Contacts that are marked as Do Not Call
           //- Attempted this in the select but ran into problem when pulling based on Contact Role
           //- Contact Role would return no results (if the one associated Contact was DNC) - this caused code to look at Account and would pull all Contacts not marked DNC
           for(integer index=0; index < contacts.size(); index++){
                if (contacts[index].DoNotCall){
                    contacts.remove(index);
                }
           }       
           
           if (contacts.size() > 1){
                Contact dummy = new Contact();
                contacts.add(0,dummy);
           }
       }
       
       
       return contacts;
    } 
}
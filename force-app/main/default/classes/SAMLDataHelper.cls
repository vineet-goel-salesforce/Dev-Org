global with sharing class SAMLDataHelper{
    Webservice static void ClearSAMLData(string userID){
        //- This method will clear SAML Data just used in jump
        //- Call this method after firing the IDP jump
        
        User currentUser = [Select ID From User where ID = :userID];
        //currentUser.SAMLData__c = null;
        update currentUser;
        
    }
    
    Webservice static List<string> SaveSAMLData(string userID, string caseType, string objectID,string serviceProviderName){
        //- This method will save key data items to the User.SAMLData__c field and
        //- then return the idp url for specified service provider
        //- serviceProviderName should be the developer name for the thier WebLink
        //- Return value will contain 2 items. First will be IDP URL and second will be any Error that is encountered
        
        List<string> saveSAMLResult = new List<string>{'',''};
        {
        try{
            User currentUser = [Select ID, ProfileID From User where ID = :userID];
           // currentUser.SAMLData__c = objectID+','+caseType;             
            update currentUser;        
                    
            //window.open('/idp/login?app=0sp3B0000004C9c','_blank');
            //WebLink serviceProvider = [Select Url From WebLink where Name = :serviceProviderName];
            //saveSAMLResult[0] = serviceProvider.Url.substring(serviceProvider.Url.indexOf('\'')+1,serviceProvider.Url.indexOf('\',\''));
            //ServiceProviderURL__c spURL = [Select SalesforceIDP__c,RelayState__c From ServiceProviderURL__c Where Name = :serviceProviderName];
            //saveSAMLResult[0] = spURL.SalesforceIDP__c;
            //if (spURL.RelayState__c != null){
              //  saveSAMLResult[0] += '&RelayState=' + spURL.RelayState__c; 
                
                //- iGo requires a GAID URL Parameter to be added as well
                /*if (serviceProviderName.toLowerCase() == 'igo'){
                    iGo__c iGoSettings = iGo__c.getInstance(currentUser.ProfileID);
                    saveSAMLResult[0] += '?gaid=' + iGoSettings.SubCompanyID__c;
                }*/
           
            
        }catch(Exception ex){
            saveSAMLResult[1] = ex.getMessage();
        }     

        return saveSAMLResult;
        }
}  
}
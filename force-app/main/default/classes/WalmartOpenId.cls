public class WalmartOpenId implements Auth.AuthProviderPlugin{
    public String getCustomMetadataType(){
        String authProvider = 'Walmart_OpenId__mdt';
        return authProvider;
    }
    
    public Auth.UserData getUserInfo(Map<String,String> authProviderConfiguration, Auth.AuthProviderTokenResponse response){
        Auth.UserData userData;
        return userData;
    }
    
    public Auth.AuthProviderTokenResponse handleCallback(Map<String,String> authProviderConfiguration, Auth.AuthProviderCallbackState callbackState){
        System.debug('\n\n\nAUTH PROVIDER CONFIG : ' + authProviderConfiguration + '\n\n\n');
        System.debug('\n\n\nCALL BACK STATE : ' + callbackState + '\n\n\n');
        Auth.AuthProviderTokenResponse  authProviderTokenResponse;
        return authProviderTokenResponse;
    }
    
    public System.PageReference initiate(Map<String,String> authProviderConfiguration, String stateToPropagate){
        System.PageReference pageReference;
        return pageReference;
    }
    
    // private static void createCallbackState(){
    //     Walmart_OpenId__mdt metadataConfig = [SELECT API_Proxy_Endpoint__c,Authorization__c,Content_Type__c,DeveloperName,Id,Label,Language,MasterLabel,MPP_Server_Endpoint__c,NamespacePrefix,QualifiedApiName,WM_CONSUMER_ID__c,WM_CONSUMER_INTIMESTAMP__c,WM_QOS_CORRELATION_ID__c,WM_SEC_AUTH_SIGNATURE__c,WM_SEC_KEY_VERSION__c,WM_SVC_ENV__c,WM_SVC_NAME__c,WM_SVC_VERSION__c FROM Walmart_OpenId__mdt WHERE DeveloperName = : 'Walmart'];
    //     System.debug('\n\n\nWALMART CONFIG : ' + metadataConfig + '\n\n\n');
        
        
    // }
}
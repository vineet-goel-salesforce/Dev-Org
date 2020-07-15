public class UserTriggerHandler {
    @future
    public static void setFederationId(Set<Id> userIds) {
        
        List<User> users = [SELECT Id, Name, Username, FederationIdentifier FROM User WHERE Id IN :userIds];
        for (User u:users) 
            u.FederationIdentifier = u.Username;
        update users;
            
    }
}
trigger userFederationId on User (before insert, after insert) { 

    /* this will raise an exception
    for (User u: Trigger.new) { 
        if(u.FederationIdentifier == null){ 
            u.FederationIdentifier = u.Username; 
        } 
    } 
    */
    if (Trigger.isInsert && Trigger.isAfter) {
    //    UserTriggerHandler.setFederationId(Trigger.newMap.keyset());
        List<User> users = [SELECT Id, Name, Username, FederationIdentifier FROM User WHERE Id IN :Trigger.newMap.keyset()];
        for (User u: users)
            u.FederationIdentifier = u.Username;
        update(users);
    }
    // userTriggerHandler.userBeforeInsert(trigger.new); 

}
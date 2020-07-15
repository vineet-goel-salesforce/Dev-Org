trigger UpdateContactsWithNewCustomerType on Account (after update) {

  If(Trigger.isUpdate)
  {
      Set<ID> ids = Trigger.newmap.keySet();
      system.debug('ids-----' + ids);    
      
      List<Account> updatedParents = [SELECT Id, (select ID, AccountID from Contacts) FROM Account WHERE Id in :ids];
      system.debug('updatedParents-----' + updatedParents); 
      List<Contact> childrenToUpdate = new List<Contact>();
      
      for (Account p : updatedParents) 
      { system.debug('Accountvalue------' +p);
          contact c = p.Contacts;
          system.debug('Contact c------' +c);
      /*   for(Contact kid : p.Contacts) 
         {  system.debug('Kid value------' +kid );
             childrenToUpdate.add(kid);
             system.debug('kid------' + kid);
          }*/
      }
     /*
      if(!childrenToUpdate.isEmpty )
      {
         update childrenToUpdate;
      }
      */
  }  
}
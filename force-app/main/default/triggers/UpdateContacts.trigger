trigger UpdateContacts on Account (after update) {
    list <Account> Acclist = new list <Account>();
    list <Contact> ConList1 = new list <Contact>();
    list <Contact> ConList2 = new list <Contact>();
    Map<id,string> lstmap = new Map<id,string>();
    set<id> AccID = new set<id>();
       for (Account acc : trigger.new)
    {    
        AccID.add(acc.Id);
        system.debug('Accountvalues-----'+acc);
        lstmap.put(acc.Id,acc.type);
        system.debug('typevalues-----'+lstmap);
     
     //list <string> AccList2 = new list <string>();
    // AccList2 = lstmap.values();
     //system.debug('values from map to list-----'+AccList2 );
          
  if (trigger.isUpdate){
   
   ConList1 = [Select Id, Department from Contact where AccountID=:AccID];
   System.debug ('Contact===='+ConList1 );
   
   for(contact c: ConList1)
   {
       if(lstmap.containskey(acc.Id) && c.Id != Null)
       {
       c.Department = lstmap.get(acc.Id);
       system.debug('contact-----'+c.Department);
       }
       ConList2.add(c);
       update ConList2;
   }
        //ConList.Department = AccList2;
  }
  }

}
trigger Accounttrigger on Account (before insert, before update) {
list <Account> Acclist = new list <Account>();
    Map<id,string> lstmap = new Map<id,string>();
    for (Account acc : trigger.new)
    {
        system.debug('Accountvalues-----'+acc);
        lstmap.put(acc.Id,acc.type);
        system.debug('Map instance-----'+lstmap);
    if(trigger.isinsert)
    {
        Acc.Site = lstmap.get(acc.Id);
        system.debug('Site details-----'+Acc.Site);
    }
      if(trigger.isupdate)
    {
        Acc.Site = lstmap.get(acc.Id);
        system.debug('Site details-----'+Acc.Site);
    } 
    }
    
}
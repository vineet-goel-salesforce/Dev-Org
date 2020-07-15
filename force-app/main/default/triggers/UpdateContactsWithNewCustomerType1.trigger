trigger UpdateContactsWithNewCustomerType1 on Account (after update) 
{
    Account acc = new Account();
    List<Contact> lstContact1 = new List<Contact>();
    List<Contact> lstContact2 = new List<Contact>();
    List<Account> lstAccount1 = new List<Account>();
    List<Account> lstAccount2 = new List<Account>();
    
    //system.debug('lstContact-----' + lstContact);    
    //system.debug('acc.Type-----'+acc.Type);
    Set<Id> accId = Trigger.newmap.keySet();
    system.debug('accId ------'+accId );
    if(trigger.isupdate)
    {            
        for(Account acc1 : Trigger.Old)
        {    
            system.debug('acc1------'+acc1);
            lstAccount1.add(acc1);
            system.debug('lstAccount1------'+lstAccount1);
            lstContact2 = [select id,department from Contact where AccountId IN : accId];
            system.debug('lstContact2------'+lstContact2);
            system.debug('accID------'+accId);
            for(Account acc2 : Trigger.New)
            {
                for(Contact con1 : lstContact2)
                {    
                    system.debug('acc2------'+acc2);
                    lstAccount2.add(acc2);
                    system.debug('lstAccount2------'+lstAccount2); 
                    if(acc1.Type != 'Customer - Direct' && acc2.Type == 'Customer - Direct')
                    {
                        system.debug('con1------'+con1);
                        con1.Department = acc2.Industry;
                        system.debug('con1.Department------'+con1.Department);
                        lstContact1.add(con1);
                    }
                }             
                update lstContact1; 
            }              
    
        }
    }
}
trigger updatelead on contact(after insert, after update)
{
    List<Lead> lstlead = new List<Lead>();
    List<Lead> leadobj = new List<Lead>();
    List<Lead> leadobj1 = new List<Lead>();
    List<Contact> lstcontact = new List<Contact>();
    integer a;
    system.debug('----lstcontact----'+lstlead);
    Map<id, string> maplst = new Map<id, string>();
    Map<id, string> maplead = new Map<id, string>();
    for(Contact c   : Trigger.new)
    {
        system.debug('----c----'+c);
        maplst.put(c.id, c.Title);
        system.debug('----maplst----'+maplst);
        lstlead = [select id, Lead_Group_number__c from lead where Contact__c =: c.id];
        system.debug('----lstlead----'+lstlead);    
              
      
    if(trigger.isupdate)
    {
        for(Lead ld: lstlead)
        {  
               ld.Lead_Group_number__c = maplead.get(c.id);
               leadobj1.add(ld);
                    
        }
        }
        if(leadobj1.size()>0){
            update leadobj1;
    }  
    }   
}
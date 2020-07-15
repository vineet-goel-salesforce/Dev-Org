trigger Updatedeparment  on Account (after update) {
    list <Account> Acclist = new list <Account>();
    list <Contact> ConList = new list <Contact>();
    list <Contact> ContList2 = new list <Contact>();
    Acclist = [SELECT Id ,type from Account where Id=:trigger.new];
    System.debug ('AcountID===='+Acclist );
    for (Account acc : trigger.new)
    {
        if (trigger.isUpdate){
            ConList = [Select Id, Department from Contact where Contact.AccountID=:Acclist];
            System.debug ('Contact===='+ConList );
   
            for(contact c: ConList){
                c.Department = acc.type ;
                ContList2.add(c);
            }
        }
        update ContList2;
  
    }
}
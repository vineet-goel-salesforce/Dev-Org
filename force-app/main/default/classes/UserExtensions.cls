public class UserExtensions{
    
    public list<User> us{get;set;}
    public list<Account> acclist;
    public string AccNames{get;set;}
    
    public list<selectoption> getAccName(){
        
        list<SelectOption> options = new list<SelectOption>();
        acclist = [Select Id, Owner.Name, Name from Account];
        System.debug('acclist---'+acclist);
        for(Account acc:acclist){
            options.add(new SelectOption(acc.Id, acc.Name));
            System.debug('options---'+options);
        }
        return options;
    }
        
    public list<User> getUserlist(){
        
        us = new list<User>();
        us = [Select Id, Name from User];
        System.debug('us---'+us);
        if(us.size()>0){
            return us;
        }else{
            return null;
        }
    }
    public pagereference ressign(){
            
        return null;
    }
}
public class accext
{
    public list<contact> conlist{get;set;}
    public list<Account> Acclist;
    public string accname{get;set;}
    
    public accext(ApexPages.StandardController stdController){  
    
        conlist = new list<contact>();      
    }
    //vineet
    public List<SelectOption> getItems() {
        
        Acclist = new list<Account>();
        Acclist = [Select Id, Name from Account];
        List<SelectOption> options = new List<SelectOption>();

        
        for(Account acc:Acclist){
            options.add(new SelectOption(acc.Id, acc.Name));
        }
        return options;
    }
    
    public void ConNames(){
        
        //Acclist = [Select Id, Name from Account where Name=:accname];
        System.debug('Acclist---'+Acclist);
        System.debug('accname---'+accname);
        conlist = [Select Id, Name from Contact where AccountId=:accname];
        System.debug('conlist---'+conlist);
    }

}
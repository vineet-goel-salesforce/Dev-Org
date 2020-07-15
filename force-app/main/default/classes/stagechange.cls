public class stagechange{
    
    public DateTime earlier{get;set;}
    public Opportunity opp;
    public Id Opid;
    public stagechange(ApexPages.StandardController crt){
        
        this.opp = (Opportunity)crt.getRecord();
        DateTime dt = System.now();
        earlier = dt.addMinutes(-1);
        system.debug('opp=='+opp);
        Opid = opp.Id;
    }
    
    public PageReference ShowMessage(){
        
        Opportunity opprt = [Select StageName, LastModifieddate from Opportunity where Id =: Opid];
        if(opprt.StageName == 'Prospecting' && opprt.LastModifiedDate > earlier){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Warning:Please direct your student to SEP.');
            ApexPages.addMessage(myMsg);
        }
        return null;
    }
}
public class contactextsn {
    
    public Contact con {get;set;}
    
    public contactextsn(Apexpages.standardcontroller stdcontroller)
    {
        con = New Contact();    
    }
    
    Public PageReference save()
    {
        insert con;
        pagereference pg = new pagereference('/'+con.id);
        return pg;
        }
        
    Public PageReference cancel()
    {
        pagereference pr = new pagereference('/003/o');
        return pr;
        }
}
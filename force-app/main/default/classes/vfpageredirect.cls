public class vfpageredirect {


     public static PageReference SamplePageRedirect1(){                  
           PageReference acctpage=new PageReference('https://vineet-dev-ed.my.salesforce.com/003');
           system.debug('test'+acctpage);
           acctpage.setRedirect(true);
           return acctpage; 
         }
}
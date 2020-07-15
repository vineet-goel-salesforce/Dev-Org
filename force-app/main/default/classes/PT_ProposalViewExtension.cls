public with sharing class PT_ProposalViewExtension {
   
    private final ApexPages.StandardController controller;
    public String redirectUrl {public get; private set;}
    public PT_ProposalViewExtension(ApexPages.StandardController controller) {
        this.controller = controller;

        //opid =  ApexPages.currentPage().getParameters().get('oppId');
    }
    public PageReference Redir() {
      string oppid;
      string ProposalID;
    redirectUrl = '';
    
      ProposalID = ApexPages.currentPage().getParameters().get('id');
      if(ApexPages.currentPage().getHeaders().get('Referer') != Null && ApexPages.currentPage().getHeaders().get('Referer') != ''){
        string urlstr = ApexPages.currentPage().getHeaders().get('Referer');
        system.debug('The url str is'+urlstr);
        if(urlstr != Null && urlstr != ''){
          pageReference PR = new PageReference(urlstr);
          oppid = PR.getparameters().get('oppId');
          system.debug('The url str is'+PR.getparameters().get('oppId'));
        }
      }
      if(oppid != Null && oppid != ''){
        redirectUrl = '/'+ ProposalID +'?OppID=' + oppid + '&nooverride=1';
      }else{
        redirectUrl = '/'+ ProposalID +'?nooverride=1';
      }
      pageReference PR = new pageReference(redirectUrl);
      system.debug('The final url is'+redirectUrl);  
      /*
       string oppid= ApexPages.currentPage().getHeaders().get('oppId');
        
        PageReference newPage;
        newPage = new PageReference ('/'+ApexPages.currentPage().getParameters().get('id'));
        newPage.getParameters().put('nooverride', '1');
        if (String.isNotBlank(oppid)) {
            newPage.getParameters().put('OPPID', oppid);
            return null;
        }*/ 
    return PR;
  }   
}
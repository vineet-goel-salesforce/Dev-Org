trigger accountFlowcheck on Account (before update) {
     
 pagereference a=new pagereference('/apex/testing');
 a.setredirect(true);
     
    
    
}
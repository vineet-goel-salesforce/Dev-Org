public with sharing class Test_k {

    public Boolean displayPopup {get;set;}

    public Test_k(ApexPages.StandardController controller) {

    }
    
    public void showPopup()
    {
        
    displayPopup = true;

    
    }
    
    public void closePopup() {
        displayPopup = false;
        
    }
    
    public PageReference redirectPopup()
    {
    displayPopup = false;
       return null;
        
    }
    


}
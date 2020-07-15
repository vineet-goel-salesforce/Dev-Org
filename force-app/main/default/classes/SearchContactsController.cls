public with sharing class SearchContactsController {
    @AuraEnabled (cacheable=true)
    public static List<Contact> searchContacts(String searchString, String accId){
        String key = '%' +searchString+ '%';
        list<contact> con = new list<Contact>();
        try{
                system.debug('key>>'+key);
                system.debug('accId>>'+accId);
            con = [Select Id, FirstName, LastName FROM Contact where AccountId =: accId AND (FirstName LIKE :key OR LastName LIKE :key)];
            system.debug('con>>>'+con);    
            if(con.size()>0){
                    return con;
                }
        }catch (Exception e){

            System.debug(Logginglevel.ERROR, e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }

        return null;
    }
}
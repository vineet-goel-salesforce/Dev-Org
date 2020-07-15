public with sharing class ContactController {
    @AuraEnabled (cacheable=true)
    public static List<Contact> getContactList(){
        return [Select Id, FirstName, LastName, Level__c FROM Contact LIMIT 10 ];
    }
}
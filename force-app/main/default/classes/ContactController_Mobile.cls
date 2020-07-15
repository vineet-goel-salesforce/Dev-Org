public class ContactController_Mobile {

    @AuraEnabled
    public static List<Contact> findAllContacts() {
        list<Contact> contacts = [SELECT id, Name, CRS_ID__c FROM Contact LIMIT 10];
        system.debug('foo first contact: ' + contacts[0]);
        return contacts;
    }

    @AuraEnabled
    public static List<Contact> findContactByName(String searchKey) {
        String name = '%' + searchKey + '%';
        return [SELECT id, Name, Phone, CRS_ID__c FROM Contact WHERE name LIKE :name LIMIT 25];
    }
 

    

    
                                                                      
                                                                      
}
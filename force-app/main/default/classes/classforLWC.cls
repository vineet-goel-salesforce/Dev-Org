public with sharing class classforLWC {
    @AuraEnabled (cacheable=true)
   public static String getgreetingMessage(String a) {
       system.debug(a);
    return a;
   }
}
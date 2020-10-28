public with sharing class BatchLeadConvert implements Database.Batchable<SObject>, Database.RaisesPlatformEvents{  
   private final String CONVERTED_STATUS = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1].MasterLabel;  
   public Database.QueryLocator start(Database.BatchableContext CTX){  
     return Database.getQueryLocator([SELECT Id FROM Lead WHERE ConvertedContactId = null]);  
   }  
   public void execute(Database.BatchableContext CTX, List<Lead> records){  
     List<Database.LeadConvert> LeadConverts = new List<Database.LeadConvert>();  
     for(Lead record:records){  
       Database.LeadConvert lc = new Database.LeadConvert();  
       lc.setConvertedStatus(CONVERTED_STATUS);  
       lc.setLeadId(record.Id);  
       LeadConverts.add(lc);  
     }  
     Database.convertLead(LeadConverts, true);  
   }  
   public void finish(Database.BatchableContext CTX){  
   }  
 }
@isTest
public class OppUpdate {

    static testMethod void runPositiveTestCases() {
     Opportunity  op= new opportunity();
     op.CloseDate = date.parse('9/30/2016');
     op.Name = 'Test SFDC';
     op.StageName = 'Completed';
     op.DeliveryInstallationStatus__c = 'completed';
     insert op;
     
     Task t= new Task();
     
     t.WhatId=op.id;  
     t.Subject = 'Test';
     t.Priority = 'Normal';
     t.Status = 'Not Started';
     insert t;
     op.Name = 'Testcompleted';
     update op;
    /* t.Status = 'Not Started';
     update t;*/
     
        } //catch
       } //RunAs(u3)
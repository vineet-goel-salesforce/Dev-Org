trigger Task_status_Completed on Task (after update) {
  static final String SUBJECT = 'Task has been Completed';
  static final String BODY = 'Status: {0}\nSubject: {1}\nType: {2}\nAssigned To: {5}\nDescription/Comments: {6}';

 // Determine the creator's email and info about InsertionOrder for each Task, since it isn't in Trigger.new

  List<Id> creatorIds = new List<Id>();
  List<Id> ownerIds = new List<Id>();
  for (Task task : Trigger.new) {
    if (task.Status == 'Completed') {
      creatorIds.add(task.CreatedById);
      ownerIds.add(task.OwnerId);
    }
  }
  // Populate hashmap of Task Id to CreatedBy User's email address
  List<User> creators = [Select Id, Email from User Where Id in :creatorIds];
  Map<Id,String> creatorIdsToEmails = new Map<Id,String>();
  for (User creator : creators) {
    creatorIdsToEmails.put(creator.Id,creator.Email);
  }
   // Populate hashmap of Owner UserId to Owner Name
  List<User> owners = [Select Id, FirstName, LastName From User Where Id in :ownerIds];
  Map<Id,String> ownerIdsToNames = new Map<Id,String>();

 for (User owner : owners) {
    ownerIdsToNames.put(owner.Id,owner.FirstName + ' ' + owner.LastName);
  }
     
  for (Task task : Trigger.new) {
    if (task.Status == 'Completed') {
      try {
        // send email to creator
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {creatorIdsToEmails.get(task.CreatedById)});
        mail.setSubject(SUBJECT);
                // build a link to the relevant proposal flight programatically
        String url = System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + task.WhatId;
        mail.setPlainTextBody(String.format(BODY,new String[]{
          task.Status, task.Subject, task.Type,url, ownerIdsToNames.get(task.OwnerId), task.Description
        }));
        Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
         
        if (!result[0].isSuccess()) {

          System.debug(LoggingLevel.ERROR, 'Failed to send email'+result[0].getErrors()[0].getMessage());
        }
       

      } catch (System.EmailException ex) {
        System.debug(LoggingLevel.ERROR, 'Encountered EmailException');
      }
    }
  }
}
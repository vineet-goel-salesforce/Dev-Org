public class testGlobalCtrl {
@AuraEnabled
    public static Task initTask(Id contactId) {

        Task t = new Task(
            Type = 'Type A',
            OwnerId = UserInfo.getUserId(),
            Status = 'Completed',
            ActivityDate = Date.today(),
            Priority = 'Normal',
            Subject = 'Notes'
        );
        System.debug('t = ' + t);
        return t;
    }
}
trigger OppUpdate on Opportunity (before update) {
List <task> ta= new List <task>();
List <task> ta1= new List <task>();
List<opportunity> oppstatus=[SELECT Id,DeliveryInstallationStatus__c,(SELECT Id,Status FROM Tasks) FROM Opportunity where Id IN :trigger.new];
for(opportunity i:oppstatus){
    system.debug('===='+i.DeliveryInstallationStatus__c);
if(i.DeliveryInstallationStatus__c=='completed'){
ta = [SELECT Id,Status FROM Task where whatId =: i.id];
}
}
for(task y:ta){
y.status='completed';
ta1.add(y);
//update y;
}
update ta1;
}
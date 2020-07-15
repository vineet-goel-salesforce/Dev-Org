trigger PersonAccountRecordTypeAssignemt on Account (before insert) {
    system.debug('==========='+trigger.new[0]);
}
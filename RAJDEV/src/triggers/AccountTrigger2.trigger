trigger AccountTrigger2 on Account (before insert,before update,after insert,after update) {
    if(trigger.isBefore && trigger.isUpdate){
        accountHelper2.validateZip(trigger.new);
    }
    if(trigger.isBefore && trigger.isInsert){
        accountHelper2.validateZip(trigger.new);
    }

}
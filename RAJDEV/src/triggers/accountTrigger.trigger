trigger accountTrigger on Account (before insert,before update) {

    if(Trigger.isBefore && Trigger.isInsert){
        accountHelper.activateAccount(Trigger.new);
        accountHelper.notifyUsers(Trigger.new);
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
       // accountHelper.validateZip(Trigger.new);
    }
}
trigger userTrigger on User (before insert) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        System.debug('Inside user before insert');
        userHelper.updateUser(Trigger.new);
    }
    
}
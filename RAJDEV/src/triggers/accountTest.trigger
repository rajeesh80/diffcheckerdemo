trigger accountTest on Account (
    before insert, 
    before update, 
    before delete, 
    after insert, 
    after update, 
    after delete, 
    after undelete) {

        if (Trigger.isBefore) {
            if(Trigger.isDelete)
            {

                ACCTHelper.deleteOp(Trigger.old);
            }
            else  if(Trigger.isInsert || Trigger.isUpdate)
            {
              System.debug('entered here');
              ACCTHelper.changeOwner(Trigger.new);

            }
        
        else if(Trigger.isAfter)
        {
            if(Trigger.isUpdate)
            {
            //  ACCTHelper.updateOpp(Trigger.new);
                //call your handler.before method
            }
        }
        
        }
}
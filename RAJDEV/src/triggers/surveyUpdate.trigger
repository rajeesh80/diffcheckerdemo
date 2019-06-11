trigger surveyUpdate on Survey_test__c (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {

		if (Trigger.isAfter) {

			if(Trigger.isInsert||Trigger.isUpdate)
			{
				System.debug('Here');
				surveyHelper.UpdateSurvey(Trigger.new);
			}
	    	//call your handler.before method
	    
		} else if (Trigger.isAfter) {
	    	//call handler.after method
	    
		}
}
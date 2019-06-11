trigger OpportunityStatus on Opportunityttset__c (before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {


	if(trigger.isAfter)
	{
		if(trigger.isInsert||trigger.isUpdate)
		{

			System.debug('I am here-----');
			opportunityHelper.updateStatus(trigger.new);
		}
	}


}
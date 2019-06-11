trigger CreateCase on Account (after insert) {
//Basic 1.0
	for(Account a: Trigger.new){
		Case c		=	new Case();
		c.AccountId = 	a.Id;
		c.Status	=	'New';
		c.Origin	=	'Web';
		c.Subject	=	'Dedupe this account';
		c.OwnerId	=	'005460000013MK4';
		c.Origin	=	'Web';
		c.Product_Purchase_Date__c = Date.today();
		c.Product_Total_Warranty_Days__c = 30;
		c.Product_Has_Extended_Warranty__c = true;
      
		insert c;
	}
}
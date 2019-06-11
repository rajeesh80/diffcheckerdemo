@isTest
private class WarrantySummaryTest {
	
	@isTest static void createCase() {
		// create case
		//set warranty related fields
		//create account
		Account myAcc							=	new Account();
		myAcc.Name								=	'TestAccount1';
		insert myAcc;
		Case myCase 							= 	new Case();
		myCase.AccountId 						= 	myAcc.Id;
		myCase.Product_Purchase_Date__c 		= 	Date.today();
		myCase.Product_Total_Warranty_Days__c 	= 	10;
		myCase.Product_Has_Extended_Warranty__c	=	true;
		myCase.Description						=	'Sample';
		myCase.Origin							=	'Web';
		insert myCase;
	}
	
}
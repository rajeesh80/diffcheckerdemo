@isTest
private class AppleWatchTest {
	
	@isTest static void createOpportunity() {
		Opportunity opp 	= 	new Opportunity();
		opp.Name 			= 	'Test1';
		opp.StageName 		= 	'Prospecting';
		opp.CloseDate 		= 	Date.today()+90;
		//causes trouble in other trigger(comparableopp) when amount is null.
		opp.Amount 			=	100;
		insert opp;
	}
	
	
}
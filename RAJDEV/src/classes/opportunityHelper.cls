/**
 * See https://github.com/financialforcedev/fflib-apex-common for more info
 *
 * Install library via
 *   https://githubsfdeploy.herokuapp.com/app/githubdeploy/financialforcedev/fflib-apex-common
 */

/**
 * Encapsulates all service layer logic for a given function or module in the application
 * 
 * For more guidelines and details see 
 *   https://developer.salesforce.com/page/Apex_Enterprise_Patterns_-_Service_Layer
 *
 **/
public class opportunityHelper
{
	public static void updateStatus(list<Opportunityttset__c>oppList)
	{
     list<Id>Id=new List<Id>();
	 for(Opportunityttset__c op:oppList)
		     {
		      if(op.Status__c=='Closed')
		      Id.add(op.AccountTest__c);
		      System.debug('---Status--------'+op.Status__c);
		      System.debug('Account Id' +op.AccountTest__c);

		     }

    List<AccountTest__c>accList=[Select Id,Status__c FROM AccountTest__c where Id IN:Id];
    List<AccountTest__c>updatedList=new List<AccountTest__c>();
    for(AccountTest__c a:accList)
	    {

	    	a.Status__c='Closed-Win';
	        updatedList.add(a);

	    }
	    System.debug('Size of Account List'+updatedList.Size());

	if(updatedList.Size()>0)
		  {
            update updatedList;

		  }
			     
		




	}




}
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
public class surveyHelper
{
	public static void updateSurvey(list<Survey_test__c>sList)
	{
	    System.debug('inside the trigger');
	     set<String>emailSt=new Set<String>();
		     for(Survey_test__c s:sList)
		     {
	          emailSt.add(s.Email_Address__c);
		     }
		 //    system.debug('First email' + emailSt[0]);
		 System.debug('Size' +emailSt.Size());
		map<String,Contact>conMap=new map<String,Contact>();
		 List<Contact> conList = [Select Name,Email from Contact where Email IN:emailSt];

		 for(Contact c:conList){
		 	conMap.put(c.Email,c);
		 }
		 System.debug('map size'+conMap.Size());
         list<Survey_test__c>updateSlist=new List<Survey_test__c>();
         for(Survey_test__c s:sList)
         {
         	String emailaddr=s.Email_Address__c;
         	System.debug('email'+emailaddr);

             String fullName=conMap.get(emailaddr).Name;
             system.debug('full anme' +fullName);
             s.Name__c=fullName;
             updateSlist.add(s);

         }
         System.debug('size new' +updateSlist.Size());

	}
}
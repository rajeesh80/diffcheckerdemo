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
public class ACCTHELPER
{
	public static void deleteOp(list<Account>Alist)
	{
    List<Id>accList=new List<Id>();
    for(Account a:Alist)
    {
    	
    	accList.add(a.Id);
    }
    List<Account>accList1=[Select id,Name,(Select Id,Description From Opportunities) From Account where Id IN:accList];
    List<Opportunity>oppList1=new List<Opportunity>();
     for(Account a:accList1)
     {
        
        for(Opportunity O:a.Opportunities)
        {
            O.Description='tEST';
            oppList1.add(O);
        }

     }

    list<Opportunity>oppList=[Select Id From Opportunity where AccountId IN:accList];
    System.debug('size'+oppList.Size());
    if(oppList.Size()>0) {
      System.debug('found');

    }

	}


     public static void changeOwner(List<Account>accList)
     {
        Set<Id>IDS=new set<Id>();
            for(Account a:accList)
            {
              IDS.add(a.OwnerId);

            }
            System.debug('size'+IDS.size());
        map<Id,User>userMap=new map<Id,User>([select Name,Id from User where Id IN:IDS]);
        List<Account>updatedAccounts=new List<Account>();
            for(Account a:accList)
            {
               User user=userMap.get(a.OwnerId);
               System.debug('name'+userMap.get(a.OwnerId).Name);
               a.SalesRep__c=userMap.get(a.OwnerId).Name;
               System.debug('salesrep'+a.SalesRep__c);
               //updatedAccounts.add(a);

            }
           /* System.debug('updtaed accounts size' +updatedAccounts.size());
            if(updatedAccounts.size()>0){
                Update updatedAccounts;
            }*/

     }


     public static void deleteOP1(list<AccountTest__c>Alist1)
     {
        System.debug('entered trigger');

       set<Id>ID=new set<Id>();
           for(AccountTest__c a:Alist1)
           {
            System.debug(a.Id);
            ID.add(a.Id);
           }
        
        List<Opportunityttset__c>oppList=new List<Opportunityttset__c>([Select Id,Name From Opportunityttset__c where AccountTest__c IN:ID]);
        System.debug('oppList size' +oppList.Size());
        if(oppList.Size()>0)
        {
            for(AccountTest__c a:Alist1)
            {
                a.addError('Cannot delete account');
            }
        }


     }
      /*public static void updateOpp(list<AccountTest__c>Alist1)
      {
        set<Id>ID=new set<Id>();

            for(AccountTest__c a:Alist1)
            {
                if(a.Status__c=='inactive')
                    {
                    ID.add(a.Id);
                    }
            }
            
        
        List<Opportunityttset__c>oppList=new List<Opportunityttset__c>([Select Id,Name From Opportunityttset__c where AccountTest__c IN:ID]);
        System.debug('OppList Size' +oppList.Size());
        List<Opportunityttset__c>updatedOp=new List<Opportunityttset__c>();        
          for(Opportunityttset__c op:oppList)
              {
                op.Status__c='inactive';
                updatedOp.add(op);
              }
        System.debug('updated op'+updatedOp.Size());
          if(updatedOp.Size()>0)
              {
                update updatedOp;
              }

        }*/
}
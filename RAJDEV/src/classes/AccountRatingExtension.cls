public class AccountRatingExtension {
    Account acct;
    public List<Opportunity> getChildOpps(){
    	return [select id,name,amount,stagename,closedate from Opportunity where accountId=:acct.id];
    }
    public AccountRatingExtension(ApexPages.StandardController stdController){
        acct = (Account)stdController.getRecord();
    }

}
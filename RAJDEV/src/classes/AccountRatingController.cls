public class AccountRatingController {
    public Account acct{get;set;}
    public List<Opportunity> childOpps{
        get{
            if (childOpps == null){
                childOpps=[select id, name, amount, closedate, stagename from opportunity where accountId=:acctId];
            }
            return childOpps;
        }
        set;
    }
    Public string acctId;
 /*   public List<Opportunity> getChildOpps(){
       // if(childOpps.size()==0){
        return [select id, name, amount, closedate, stagename from opportunity where accountId=:acctId];
     //   }
       // else return childOpps;
    }*/
    public AccountRatingController(){
        acctId = ApexPages.currentPage().getParameters().get('Id');
        system.debug('account id'+acctId);
        acct = [select name,rating from account where id=:acctId];
    }
    public PageReference save(){
        update acct;
        return new PageReference('/'+acct.Id);
    }
}
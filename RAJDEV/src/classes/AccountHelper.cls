public class AccountHelper {
    public static void activateAccount(List<Account> acctList){
        for(Account acct: acctList){
            acct.active__c='Yes';
        }
    }
    public static void validateZip(List<Account> acctList){
        Set<String> cities = new Set<String>();
        for(Account a1:acctList){
            cities.add(a1.billingcity);
        }
        // Map<String,List<citydata__c>> cityZipMap = new Map<String, List<citydata__c>>();
        List<citydata__c> cityZipList =  [Select city__c,zip__c from citydata__c where city__c=:cities];
        Set<String> zipCodes = new Set<String>();
        for(citydata__c c:cityZipList){
            zipCodes.add(c.zip__c);
        }
        System.debug('city zip data'+cityZipList);
        for(Account a: acctList){
            if(zipCodes.contains(a.BillingPostalCode)){
                System.debug('inside contains');
            }
            else{
                a.BillingPostalCode.addError('Invalid Zip');
            }
            System.debug('inside validateaccount');
        }
    }
    public static void notifyUsers(List<Account> acctList){
        List<String> messages = new List<String>();
        for (Account ta : acctList) {
           messages.add('New account created');
        }
        // Publish messages as notifications
        NotificationController.publishNotifications(messages);
    }
}
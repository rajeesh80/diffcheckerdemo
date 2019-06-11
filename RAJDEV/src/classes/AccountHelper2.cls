public class AccountHelper2 {
    public static void validateZip(List<Account> accntList){
        System.debug('actlist'+accntList);
        boolean invalidZip = false;
        //Bulkify - assume the list contains 200 records.
        //for the records in list, make one soql query to get the list of zips
        //if the selected billing zip is not in the list of zips queried, throw an error.
        Set<String> cities = new Set<String>();
        for(Account a: accntList){
            cities.add(a.BillingCity);
        }
        List<citydata__c> zipList = new List<citydata__c>([select zip__c from citydata__c where city__c=:cities]); 
        for(Account acnt: accntList){
            //avoid second looping
            for(citydata__c city:zipList){
                if(acnt.BillingPostalCode == city.zip__c){
                    
                }
                else{
                 	invalidZip = true;   
                }
                    
            }
            if(invalidZip){
                invalidZip = false;
            	acnt.BillingPostalCode.addError('Invalid Zip');
            }
            
        }
    }
}
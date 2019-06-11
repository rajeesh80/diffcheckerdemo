public with sharing class ListRaceApexController {
	@AuraEnabled
    public static List<Race__c> getRacesDB() {
        return [SELECT Id, Name, DateTime__c,Attended__c,Type__c, Result__c from Race__c];
    }
}
public with sharing class DataTableController {

    @AuraEnabled
    public static List<Contact> getContactList(){
    	return [Select FirstName,LastName,Phone,Email,Title from Contact order by createddate desc limit 10];
    }
}
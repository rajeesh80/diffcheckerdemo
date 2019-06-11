@isTest
private class DataTableExportController_Test {
	
	static testmethod void validateController() {
		 List<Contact> cons = new List<Contact>();
		 for(integer i = 0;i < 10;i++){
		 	Contact con = newContact(i);
		 	cons.add(con);
		 }
	}
	public static Contact newContact(Integer i) {
        system.debug('===>>inside newContact');
        return new Contact(
            LastName = 'TESTCONTACT' + i,
            FirstName = 'testcon' + i
        );
    }   
}
@isTest
private class DataTableExportExtension_Test {
	
	static testmethod void validateController() {
		 List<Contact> cons = new List<Contact>();
		 for(integer i = 0;i < 10;i++){
		 	Contact con = newContact(i);
		 	cons.add(con);
		 }
		 // Set test page passing initial parameters.
        PageReference vfPage = Page.DataTableWithExportToPDF;
        vfPage.getParameters().put('PDFData', 'Test Value');
        test.setCurrentPage(vfPage);

        List<Contact> conts = new List<Contact>();
        Apexpages.StandardSetController sc = new Apexpages.standardSetController(conts);
        DataTableExportExtension ext = new DataTableExportExtension(sc);

        ext.PDFData = 'check';
        System.assertEquals('check', ext.PDFData);

        vfPage.getParameters().put('pData', JSON.serialize(cons));
        ext.setData();
        //System.assertEquals('tested', ext.getPDFData());
        //System.assertEquals('tested', ext.anyMethod01());          

        //ext.setPDFData('tested2');
        PageReference testPageResults = ext.downloadPDF();
        //System.assertEquals(txt, testPageResults.getParameters().get('test'));    
	}
	public static Contact newContact(Integer i) {
        system.debug('===>>inside newContact');
        return new Contact(
            LastName = 'TESTCONTACT' + i,
            FirstName = 'testcon' + i
        );
    }   
	
}
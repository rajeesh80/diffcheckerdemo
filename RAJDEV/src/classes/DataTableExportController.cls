public with sharing class DataTableExportController {
	public String PDFData {get; set;}    	
	public DataTableExportController() {
		
	}
	public PageReference downloadPDF(){
        System.debug('PDFData:inside download:'+PDFData);
        System.PageReference pageRef = new System.PageReference('/apex/PDFPage');
        pageRef.getHeaders().put('content-disposition','attachment; filename=TestPDF.pdf');
        return pageRef;
    }
}
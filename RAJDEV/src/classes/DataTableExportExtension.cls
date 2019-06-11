public with sharing class DataTableExportExtension {

	public List<Contact> cons;
    //public String val{get;set;}
    public String PDFData{get;set;}
    //public String test ='this is a test'; 
    //public List<String> header;
    //public Date Today { get { return Date.today(); }}
    private ApexPages.StandardSetController ctrl {get;set;}

    public DataTableExportExtension(ApexPages.StandardSetController stdSetController) {
        ctrl = stdSetController;

    }
    public PageReference downloadPDF(){
        System.PageReference pageRef = new System.PageReference('/apex/PDFPage');
        pageRef.getHeaders().put('content-disposition','attachment; filename=TestPDF.pdf');
        pageRef.setRedirect(false);
        return pageRef;
    }
    public void setData(){
        cons=(List<Contact>)JSON.deserialize(Apexpages.currentPage().getParameters().get('pData'), List<Contact>.class);
    }
    public List<Contact> getCons() {
       return cons;
    }
}
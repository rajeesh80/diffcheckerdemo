public class caseRemoteExtension {
    public list<case__mdt> pickLists{get;set;}
    public string pickListStr {get;set;}
    public string recType {get;set;}
    public caseRemoteExtension(ApexPages.StandardController stdController){
        String recordType = System.currentPageReference().getParameters().get('recordType');
        system.debug('recordType'+recordType);
		//CasePicklistValues__mdt[] pickLists = [SELECT FieldName__c,RecordType__c,ControllingField__c,ControllingFieldValue__c,Value__c,api_name__c from CasePicklistValues__mdt where RecordType__c='SalesAndService' order by Value__c asc];
        case__mdt[] pickLists = [SELECT FieldName__c,RecordType__c,ControllingField__c,ControllingFieldValue__c,Value__c,api_name__c from case__mdt where RecordType__c=:recordType order by Value__c asc];
        pickListStr = JSON.serialize(pickLists);
        recType=recordType;
    }
    @RemoteAction
    public static void createCase(String caseDetails){
        System.debug('Inside method call');
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        //dmlOpts.assignmentRuleHeader.assignmentRuleId=Label.Case_Site_Assignment_Rule_Id;
        Case c =(Case) JSON.deserialize(caseDetails, Case.class);
        c.setOptions(dmlOpts);
        insert c;
    }
}
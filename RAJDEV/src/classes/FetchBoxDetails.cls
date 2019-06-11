public with sharing class FetchBoxDetails {
    /*ROTHENANDIYIL 5/5/2017 This class handles all the methods needed for lightning components(Box and Detail).
     * 1. Get the count of objects during intialization of the boxes.
     * 2. Onclick of the box, get the detail table content as a list and the table header as a map. returned these objects using a wrapper class.
     * 3. Get list views when clicked on view all link. Returns all the lists views to js controller and will use one of these cases
     * 		i. Look for something like Object+' Box Detail' -> if it is present navigate to this view (this view has the exact columns and filter criteria
     * 		   as that of the box design parameters)--> this was a design prior to feedback/just to make a generic solution.
     * 		ii. IF i is not present, look for All Objects or Recently Viewed list views. (May or may not present for all objects!)
     *  --Since this is a POC at this point, may need to change these aspects later when requirements are clearer.
     */
    @AuraEnabled
    public static List<ObjWrapper> fetchDetailsDB(String objType,String objAttr,String strWhereClause,String sortSpec,String soqlLimit){
        //To avoid all null scenarios, defaulting the parameters to some value.
        //This is not a valid scenario.(Admin should always input these attributes during page design time)
        //This counters cases when components are picked either in an app or salesforce1 page without required attributes.(in future!)
        if(String.isBlank(objType)) objType = 	'Opportunity';//String.isBlank(objType) objType==null
        if(String.isBlank(objAttr)) objAttr = 	'Id,CreatedDate';//some columns that every object has
        if(String.isBlank(strWhereClause)) strWhereClause = 'CreatedDate=TODAY';//some query that can be used on every object that will not blow up everything.
        if(String.isBlank(soqlLimit)) soqlLimit ='100';//Putting a hard limit of 100 if not provided just to be safe.
		if(String.isBlank(sortSpec)) sortSpec = 'CreatedDate DESC';//default sort spec.
        System.debug('Inside fetch box details db: Object Type'+objType);
        System.debug('Inside fetch box details db: Object Attr'+objAttr);
        System.debug('Inside fetch box details db: Whereclause'+strWhereClause);
        System.debug('Inside fetch box details db: SOQLLimit'+soqlLimit);
        System.debug('Inside fetch box details db: sort spec'+sortSpec);
 		
        //Prepare dynamic SOQL from attributes that are passed from box and execute query.
        String dynSOQL			  		= 	'SELECT '+objAttr+' FROM '+objType+' WHERE '+strWhereClause+' ORDER BY '+sortSpec+' LIMIT '+soqlLimit;
        System.debug('dynSOQL'+dynSOQL);
        List<sObject> records 	  		= 	Database.query(dynSOQL);
		
        //Get field labels as a Map. (list was considered initially!)
        Map<Integer,String> hdrMap 		= 	getFieldLabels(objType,objAttr);
		
        //Create the wrapper object to return that contains headerMap and objectList.
		//Ideally no need of a List<ObjWrapper> as this list contains only one object all the time
        ObjWrapper ow;
        ow								=	new ObjWrapper(hdrMap,records);
        List<ObjWrapper> owList			=	new List<ObjWrapper>();
        owList.add(ow);
        return owList;
    }
    @AuraEnabled
    public static Integer getBoxCountDB(String objType,String strWhereClause){
        //Fired when boxes are initialized. Returns the count of objects that is displayed on the box.
        Integer count					=	0;
        if(String.isBlank(strWhereClause)) strWhereClause 	= 	'CreatedDate= TODAY';//Just to avoid a scenario where there is a blank where clause.
        String dynSOQL			  		= 	'SELECT count() FROM '+objType+' WHERE '+strWhereClause;
        count							=	database.countQuery(dynSOQL);
        System.debug('dynSOQL'+dynSOQL);
        System.debug('Box Count'+count);
        return count;
    }
    @AuraEnabled
    public static List<ListView> getListViewDetails(String objType){
        //Find all the list view for the box, and process it from js controller.This is used when user clicks on view all link
        //To navigate to a list view.(Object+' Box Detail' or to All Objects view)--> initial design choice, may change in future.
        List<ListView> listViews 		= 	[SELECT Id, Name FROM ListView WHERE SobjectType =:objType];
        return listViews;
    }
    
    public static Map<Integer,String> getFieldLabels(String objType,String strFields){
        /*ROTHENANDIYIL 5/10/2017 Started writing this method using list, but encountered a problem with repetitive null values getting added at the
         *end of the list and order was not getting preserved (table header and table body needs to have columns in same order in js controller.)
		 *Switched to a map.  
         */
        
        //Map of field, label
        //strFields is a comma seperated string of field API names
        if(String.isBlank(objType)) objType		=	'Opportunity';//just set some object in case it is passed as blank.
        if(String.isBlank(strFields)) strFields = 	'Id,CreatedDate';
        //     System.debug('inside getfieldlabels- objType'+objType);
        //     System.debug('inside getfieldlabels- strfields'+strFields);
        
        //Get Field API Names in a list.
        List<String> strFieldList				=	strFields.split(',');
        
        //Use describe to get the label of fields from API names.
        //Iterate throgh the fields that are in the field list.
        Map<Integer,String> labelMap			=	new Map<Integer,String>();//[strFieldList.size()];//list.add(index,elmnt) throwing list out of bound exception.
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType objSchema 			= schemaMap.get(objType);
        Map<String, Schema.SObjectField> fieldMap = objSchema.getDescribe().fields.getMap();
        
        //Counter to fix the relative position of the field name with respect to the api name. (the order in which these fields are keyed in objAttr input as the sObject list
        //contains columns in this order.when table header and body are constructed dynamically using js, need to maintain this order to make sure that values match labels.) 
        Integer i=0;  
        for(String field: strFieldList){
            //In case admin keys in a whitespace between attributes (for ex. Id, Name, Email etc.)
            //REMOVE WHITE SPACE
            field = field.trim();      
            System.debug('Index i:'+i+':: field:'+field);           
            labelMap.put(i,fieldMap.get(field).getDescribe().getLabel());
            i++;
            
        }
        
        System.debug('labelMap:'+labelMap);
        return labelMap;
    }
    public class ObjWrapper 
    {
        //Wrap a map and list so that it can be returned to the caller as single list object.
        @AuraEnabled public Map<Integer,String> headerMap;
        @AuraEnabled public List<sObject> objList;
        public ObjWrapper(Map<Integer,String> hdrMap,List<sObject> oList)
        {
            headerMap	=	hdrMap;
            objList		=	oList;            
        }
        
    }
    
}
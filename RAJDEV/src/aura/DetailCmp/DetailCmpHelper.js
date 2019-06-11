({	doInitHelper	: function(component,event){
    //Hide View All link by default.
    var viewAllLink = component.find('detailTableViewAll');
    $A.util.addClass(viewAllLink, 'slds-hide');
    
    
},
  refreshTableHelper : function(component, event) {    
      var objs 		= 	component.get('v.objs');
      var objAttr =event.getParam('objAttr');
      var listView	=	event.getParam('listView');
      console.log('refreshtablehelper list view'+listView);
      console.log('objAttr in refreshtable'+objAttr);
      var headerArray		=	[];
      headerArray			=	objAttr.split(',');
      //This doesnt work, as header contains label now and not API names. Use headerarray.
      // var fieldList 	= 	component.get('v.header');
      var fieldList		=	headerArray;
      var pageSize	=	component.get('v.page');
      document.getElementById('data').innerHTML ="";
      var boxNum		= 	event.getParam('boxNum');
      console.log('boxNum-refreshtable'+boxNum);
      console.log('obj length'+objs.length);
      console.log('objs'+objs);
      //limits- write a seperate function
      var limits	=event.getParam('limits');
      var limitsArray	=	[];
      if(limits ==undefined) limits='100;10';
      console.log('limits'+limits);
      limitsArray		=	limits.split(';');
      var soqlLimit	=	limitsArray[0];//first part is SOQL limit and second part is the limit of the number of records in detail table.
      var tableLimit	=	limitsArray[1];
      console.log('tablelimit'+tableLimit);
      var i=1;
      /* This function iterates through object records & fields in the list and create a table dynamically.
         */
      objs.forEach(function(s) {
          //limits second parameter is table limit. Restrict the table size to table limit
          if(i<=parseInt(tableLimit))
          {
              var tableRow = document.createElement('tr');
              fieldList.forEach(function(field){ 
                  var tableData = document.createElement('td');              
                  var tableDataNode = document.createTextNode(s[field]);
                  tableData.appendChild(tableDataNode);
                  tableRow.appendChild(tableData);
              });
              document.getElementById("data").appendChild(tableRow);
          }
          else
          {
              //no more to add to table. Display view all link by unhiding the element.
              //do it after the object iteration.
          }
          i++;  
      });
      //Show view all link when there are more records than table limit.
      var viewAllLink = component.find('detailTableViewAll');
      if(boxNum>tableLimit){        
          $A.util.removeClass(viewAllLink, 'slds-hide');
      }
      else{
          $A.util.addClass(viewAllLink, 'slds-hide');
      }
      
  },
  fetchDetailsHelper: function(component,event){
      var action 	= 	component.get('c.fetchDetailsDB');//server side controller function call.
      var objType 	=	event.getParam('objType');
      var objAttr 	=	event.getParam('objAttr');
      var limits	=	event.getParam('limits');
	  var listView	=	event.getParam('listView');
      component.set('v.listView',listView);
      console.log('fecthdetailshelperlist view'+listView);
      // var boxNum	= event.getParam('boxNum');
      var limitsArray	=	[];
      if(limits ==undefined) limits='100;10';
      console.log('limits'+limits);
      limitsArray		=	limits.split(';');
      var soqlLimit	=	limitsArray[0];//first part is SOQL limit and second part is the limit of the number of records in detail table.
      var tableLimit	=	limitsArray[1];
      var strWhereClause = event.getParam('srchString');
      //get box color, parse background color and set in border color attribute.
      var boxStyle	=	event.getParam('color');
      console.log('border color in detail cmp'+boxStyle);
      var boxStyleArray	=	[];
      if(boxStyle !=undefined){
          boxStyleArray		=	boxStyle.split(';');
          var boxBackgroundColorCode	=	boxStyleArray[0].substr(boxStyleArray[0].indexOf('#'));
          //boxBackgroundColorCode		=	"width:60.00rem;border-style:double; border-color:"+boxBackgroundColorCode;
          console.log('BGColorCode'+boxBackgroundColorCode);
          component.set('v.border-color',boxBackgroundColorCode);
          var detailTable	=document.getElementById("DetailTable");
          detailTable.style["border-color"] = boxBackgroundColorCode;
          detailTable.style["border-style"] = "solid";
          detailTable.style["border-width"] = "15px";
          // detailTable.style["margin-right"] = "50px";
          //detailTable.style["border-radius"] = "15px";
      }
      else
      {
          //this is not really used.
          component.set('v.border-color','width:60.00rem;border-style:solid; border-color:black');
      }
      
      //objAttr is a comma seperated string of fields/header columns.
      //create a string array and set it in view to iterate & generate header dynamically.
      var headerArray		=	[];
      //Get header array from server side call
      //Get labels of the fields from API Names
      //  this.setTableHeader(component,event);
      //headerArray			=	component.get('v.header');
      headerArray			=	objAttr.split(',');
      var sortSpec			=	event.getParam('sortString');
      action.setParams({"objType": objType,
                        "objAttr": objAttr,
                        "strWhereClause":strWhereClause,
                        "sortSpec":sortSpec,
                        "soqlLimit":soqlLimit});
      action.setCallback(this, function(response){
          var state = response.getState();
          if(component.isValid() && state==="SUCCESS"){
              //Object wrapper returns a list of ObjWrapper class which contains a map and a list of sObjects.
              //map<integer,string> has a position that is in tact with the data fetched in list<sObject>, label.
              //list<sObj> is the list of records from the dynamic soql.
              var objWrapper = response.getReturnValue();
              console.log('OW'+objWrapper);
              
              var returnVal	=	objWrapper[0];
              var hMap = returnVal.headerMap;//List distorts the result by adding the elements twice.Going with map.
              var oList	=	returnVal.objList;
              for (var key in oList) {
                  if (oList.hasOwnProperty(key)) {
                      console.log("Olist Key:"+key + " -> " + oList[key]);
                  }
              } 
              component.set('v.objs',oList);  
              //set from init by getting labels.
              //iterate through map and get the value - order is preserved
              var fieldArray = [];
              var arrayCounter = 0;
              var j=0;
              for(var field in hMap){
                  //for(var label in headerArray){
                  if(hMap.hasOwnProperty(field)){
                      console.log('hMap Values in order:'+hMap[field]);
                      fieldArray.push(hMap[j]);
                  }
                                      j++;
                     // }
              }
              component.set('v.header',fieldArray);
              component.set('v.headerMap',hMap);
              component.set('v.tableLimit',parseInt(tableLimit));
              component.set('v.objType',objType);//This needs to be set for further events like view all.
  			  this.refreshTableHelper(component,event);
          }
          else if(state==="ERROR"){
              //Error Handling.
              //There are 6 states possible
              //New, Running, Success, Error, Incomplete, Aborted
              var errors = response.getError();
              if(errors){
                  if(errors[0]&&errors[0].message){
                      console.log("Error Message"+errors[0].message);
                  }
              }
              else
              {
                  console.log("unknown error");
              }
              
          }
              else
              {
                  console.log("action state returned was"+state);
              }
          
      }                
                        );
      console.log('inside DetailCmpController-fetchDetails:End');
      $A.enqueueAction(action);
  },
  gotoObjListHelper : function(component,event){
      //this is navigating to an already existing list view
      //what is needed is navigating to a dynamically constructed list.
      var obj		 = component.get('v.objType');
      //console.log('obj from event'+event.getParam('objType'));
      var action	 = component.get('c.getListViewDetails');
      var listView	= component.get('v.listView');
      console.log('gotoObjListHelper list view'+listView);
      action.setParams({
          "objType":obj
      });
      action.setCallback(this, function(response){
          var state = response.getState();
          if(component.isValid() && state==="SUCCESS"){
              var listViews = response.getReturnValue();
              // console.log('listviews'+listViews);
              var listViewId	='';
              var tmpStr		='';
              var lvName 		= '';
              var lvId		= '';
              var objLV	 	= '';
              var listViewName ='';
              if(listView!=''){
                  listViewName=listView;
              }
              
              //listViewName = obj+' Box Details';//what about custom objects?Custom__c Box Details?   
              for(var i=0;i<listViews.length;i++){ //iterate through list of listviews
                  //console.log('listviews:'+i+':'+listViews[i]);
                  //console.log('listview id'+listViews[i]['Id']);
                  //console.log('listview Name'+listViews[i]['Name']);
                  
                  tmpStr 		= listViews[i]['Name'];
                  if(listViews[i]['Name']==listViewName){
                      lvName 	= listViews[i]['Name'];
                      lvId	= listViews[i]['Id'];
                      console.log('final listview id'+lvId);
                  }
                  if(lvName ==''){
                      //In case Opportunity Box Details list view is not present, use All Opportunities view.
                      if(tmpStr.includes('All')){
                          lvName 	= listViews[i]['Name'];
                          lvId	= listViews[i]['Id'];
                      } 
                  }
              }
              
              //this.navigateToListView(component,event);
              console.log('navigate to list view: start');
              console.log('navid :'+lvId);
              console.log('obj type: '+obj);
              var navEvent = $A.get('e.force:navigateToList');
              console.log('navEvent'+navEvent);
              navEvent.setParams({
                  "listViewId": lvId,
                  "listViewName": null,
                  "scope": obj
              });
              navEvent.fire();
              console.log('navigate to list view: end');
          }
          else if(state==="ERROR"){
              var errors = response.getError();
              if(errors){
                  if(errors[0]&&errors[0].message){
                      console.log("Error Message"+errors[0].message);
                  }
              }
              else
              {
                  console.log("unknown error");
              }
              
          }
              else
              {
                  console.log("action state returned was"+state);
              }
          
      }                
                        );
      $A.enqueueAction(action);
      
  }
  
 })
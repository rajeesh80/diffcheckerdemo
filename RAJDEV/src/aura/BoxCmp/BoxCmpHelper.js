({
    doInitHelper : function(component,event) {
        var objType			=	component.get('v.objType'); 
        var strWhereClause 	= 	component.get('v.srchString');
        //console.log('where'+strWhereClause);
        var action 			= 	component.get('c.getBoxCountDB');
        action.setParams({"objType":objType,
                          "strWhereClause": strWhereClause});
        action.setCallback(this, function(response){
            var state 		= 	response.getState();
            var returnVal	=	response.getReturnValue();
            //console.log('return'+returnVal);
            
            if(component.isValid() && state==="SUCCESS"){
                component.set('v.boxNumber',parseInt(returnVal));  
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
            
        }  );              
        //console.log('Inside BoxCmpController - doInit: End');             
        $A.enqueueAction(action);
    },
    fireEvtHelper:function(component,event){
        // console.log('Inside BoxCmpController - fireEvt: Start');
        var objType			=	component.get('v.objType'); 
        var objAttr			=	component.get('v.objAttr');
        var color			=	component.get('v.color');
        var strWhereClause	=	component.get('v.srchString');
        var limits			=	component.get('v.limits');
        var boxNum			=	component.get('v.boxNumber');
        var sortSpec		=	component.get('v.sortString');
        var listView		=	component.get('v.listView');
        //console.log('fire event:boxnum'+boxNum);
        var appEvent 		= 	$A.get("e.c:FetchDetailsEvt");
        //console.log('fireEvt:objType'+objType);
        //console.log('fireEvt:objAttr'+objAttr);
        //console.log('fireEvt:appEvent'+appEvent);
        appEvent.setParams({"objType" : objType,
                            "objAttr" : objAttr,
                            "srchString":strWhereClause,
                            "sortString":sortSpec,
                            "limits":limits,
                            "boxNum":boxNum,
                            "listView":listView,
                            "color"	: color});
        appEvent.fire();
        
    }
})
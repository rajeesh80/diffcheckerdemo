({
    doInit		: function(component,event,helper){
       helper.doInitHelper(component,event);   
    },
    refreshTable : function(component, event, helper) {
        //console.log('DetailCmpController refreshTable: Start');
        helper.refreshTableHelper(component,event);
        //console.log('DetailCmpController refreshTable: End');
    },
    gotoObjList : function(component, event, helper) {
        helper.gotoObjListHelper(component,event);
        
    },
    fetchDetails : function(component, event, helper) {
        //console.log('DetailCmpController-fetchDetails:Start');
        helper.fetchDetailsHelper(component,event);
        //console.log('DetailCmpController-fetchDetails:End');
    }
})
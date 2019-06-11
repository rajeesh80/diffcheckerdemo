({
	doInit : function (component, event, helper){
		  helper.loadData(component);		  
    },
    exportToPdf : function (component, event, helper){
    	console.log('export to pdf clicked:controller');
		  helper.exportData(component);		  
    },
    handleRowAction: function (cmp, event, helper) {
    var action = event.getParam('action');
    var row = event.getParam('row');
    cmp.set('v.contact',row);
    console.log('rowId'+cmp.get('v.contact').Id);
    var modalBody,modalHeader,modalFooter;
	    switch (action.name) {
	        case 'show_details':
            //alert('test');
            //return;
	            $A.createComponents([
	                ["c:ContactDetailsCmp",{"recordId":cmp.get('v.contact').Id}],
	                ["c:FooterCmp",{}],
	                ["c:HeaderCmp",{}]
	            ],
                function(components, status){
                    if (status === "SUCCESS") {
                        modalBody = components[0];
                        modalHeader = components[2];
                        modalFooter=components[1];
                        try{
                            cmp.find('overlayLib').showCustomModal({
                                header: modalHeader,
                                body: modalBody,
                                footer:modalFooter,
                                showCloseButton: true,
                                closeCallback: function() {
                                    console.log('Details modal closed!!!');
                                    
                                }
                            });
                        }
                        catch(e){
                            alert('exception while finding overlay library');
                            //no luck
                        }
                    }
                }
               );//Create component end
	        
	        //alert('Showing Details: ' + JSON.stringify(row));
	       
	            break;
	    }
	},
})
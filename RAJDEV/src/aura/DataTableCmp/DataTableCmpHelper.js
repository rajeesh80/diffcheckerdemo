({
	loadData : function(cmp) {
        var actions = [
            { label: 'Details', name: 'show_details' }
        ];

        cmp.set('v.tableColumns', [
                {label: 'First Name', fieldName: 'FirstName', type: 'text'},
                {label: 'Last Name', fieldName: 'LastName', type: 'text'},
            	{label: 'Phone', fieldName: 'Phone', type: 'phone'},
                {label: 'Email', fieldName: 'Email', type: 'text'},
                {label: 'Job Title', fieldName: 'Title', type: 'text'},
                {type: 'action', typeAttributes: { rowActions: actions } }
        ]);
        var action 			= 	cmp.get('c.getContactList');
        //action.setParams({"limit":10});//dummy param- no need
        action.setStorable();//caching 
        action.setCallback(this, function(response){
            var state 		= 	response.getState();
            var returnVal	=	response.getReturnValue();
            if(cmp.isValid() && state==="SUCCESS"){
                cmp.set('v.contacts',returnVal);  
            }
            //Error Handling.
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
            
        }  );                         
        $A.enqueueAction(action);
	},
    exportData: function(cmp){
        console.log('export clicked');
        var sendDataProc = cmp.get("v.sendData");
        /*var dataToSend = {
         "label" : "This is a test but let s see the view state f the vfp to sdfskbjdfbs sdfkbsdjf sdfnsjdfs dsfjhjdsfnkjsd sdfsdkjfs f"
        }; */
        var dataToSend = cmp.get('v.contacts');
        sendDataProc(dataToSend, function(){
            console.log('handle cb here');
        });
    }
})
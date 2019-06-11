({
	loadData : function(cmp) {
        //FirstName,LastName,Phone,Email,Title
        cmp.set('v.tableColumns', [
                {type:  'button', iconName: 'utility:edit', label: 'Edit', name: 'editRecord', title: 'editTitle', disabled: false, value: 'test'},
                {label: 'First Name', fieldName: 'FirstName', type: 'text'},
                {label: 'Last Name', fieldName: 'LastName', type: 'text'},
            	{label: 'Phone', fieldName: 'Phone', type: 'phone'},
                {label: 'Email', fieldName: 'Email', type: 'text'},
                {label: 'Job Title', fieldName: 'Title', type: 'text'}
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
	}
})
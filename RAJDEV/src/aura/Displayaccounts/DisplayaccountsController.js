({
	doFetch : function(component, event, helper) {
        console.log("begin account fetch");
        var accountAction=component.get("c.accList");
        //accountAction.setParams({"accountId":'00123423422'});
        accountAction.setCallback(
            this, 
            function(accResponse){
                //Displayaccounts.set("v.Accounts",accResponse.getReturnValue());
                component.set("v.Accounts",accResponse.getReturnValue());
            }
        );
        $A.enqueueAction(accountAction);//Adds to a queue
        console.log("end account fetch");		
	}
})
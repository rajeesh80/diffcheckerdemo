({
	doHandle : function(component, event, helper) {
		console.log("Begin doHnadle1");
        var res=event.getParam("myCode");
        console.log("code" +res);
        console.log("END doHandle1");
		
	}
})
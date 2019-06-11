({
	doSubmit : function(comp, evt, helper) {
		console.log("----begin child comp---- ");
		var getEvt=comp.getEvent("samplecompevt");
		getEvt.setParam("Alpha",comp.get("v.alpha"));
		var myalbha=comp.get("v.alpha");
		console.log(myalbha);
		console.log("before firing");
		getEvt.fire();
        console.log("---End child comp--- ");

	}
})
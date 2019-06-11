({
	doHandle : function(comp, evt, helper) {
		console.log("----begin parent-----");
		var mychar=evt.getParam("Alpha");
		console.log(mychar);
		console.log("----end parent-----");
	}
})
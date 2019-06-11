({
	doFire : function(component, event, helper) {
        
        console.log("Begin AppEvent");
        var myEvt=$A.get("e.c:CustomAppEvent");
        var myCode1=component.get("v.myCodeFire");
        console.log("from the fire comp"+myCode1);
        myEvt.setParams({"myCode":myCode1});
        myEvt.fire();
        console.log("END Appevent");
		
	}
})
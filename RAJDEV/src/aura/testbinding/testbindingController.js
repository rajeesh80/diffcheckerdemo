({
	doInit : function(component, event, helper) {
        var cmp=component.get('v.test');
        console.log("value:::"+cmp);
        component.set('v.test','newval');
        var cmp1=component.get('v.test');
        console.log("changed" +cmp1);
	}
})
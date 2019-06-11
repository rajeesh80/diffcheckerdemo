({
	doInit : function(component, event, helper) {
		console.log('inside contact details'+component.get('v.recordId'));
	},
	closeModal: function(component,event,helper){
		component.find("overlayLib").notifyClose();
	}
})
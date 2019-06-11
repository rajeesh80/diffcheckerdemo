({
	doInit : function(component, event, helper) {
		console.log('inside init');
        var card = JSON.parse(component.get('v.root')).card;
        component.set('v.card',card);
        component.set('v.data',card.items);
        component.set('v.layout',card.layout);
        //component.set('v.validation',card.validation);
        component.set('v.action',card.actions);
        component.set('v.isLoaded',true);
	}
})
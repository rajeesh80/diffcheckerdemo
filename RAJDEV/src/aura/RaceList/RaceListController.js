({
	doInit : function(component, event, helper) {
        console.log('------Inside RaceListController:Start------');
        helper.getRaces(component);
        console.log('----RaceListController:End----');
	},
    refreshRaceList: function(component, event, helper){
        console.log('------Inside refresh race list--start- ');
        helper.addToList(component,event);
        console.log('------Inside refresh race list--end- ');
        
    },
 
})
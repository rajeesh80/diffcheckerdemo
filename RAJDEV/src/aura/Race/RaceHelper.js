({
	   updateRace	:	function(component){
        console.log('inside helper- update race: start');
        var race	=	component.get("v.race");
        var action	=	component.get("c.updateRaceDB");
        action.setParams({"race": race});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid()&&state==="SUCCESS"){
                component.set('v.race',response.getReturnValue());    
            }
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
        });
     
        $A.enqueueAction(action);
        console.log('inside helper- update race: end');
    }
	

})
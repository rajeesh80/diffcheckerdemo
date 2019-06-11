({
	loadOptions : function(component) {
        //showing default values for picklist.
        //input text doesnt show it because of product defect.
		var types = [{class:"optionClass",label:"5k",value:"5k"},
                     {class:"optionClass",label:"10k",value:"10k"},
                     {class:"optionClass",label:"Half-Marathon",value:"Half-Marathon"},
					 {class:"optionClass",label:"Full-Marathon",value:"Full-Marathon"}
                    ];
        component.find("Type").set("v.options",types);


	},
    createNewRace: function(component){
        console.log('--inside helper function create new race--');
        var action = component.get("c.newRaceDB");
        console.log('--inside helper function create new race--action'+action);
        console.log('-----getting new race from view'+component.get("v.newRace"));
        action.setParams({"race":component.get("v.newRace")});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state==="SUCCESS"){
                console.log("Race successfully created");
                var appEvent = $A.get("e.c:AddToRaceList");
                appEvent.setParams({"race" : response.getReturnValue()});
                appEvent.fire();
            }
            else if(state==="ERROR"){
                //Error Handling.
                //There are 6 states possible
                //New, Running, Success, Error, Incomplete, Aborted
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
    }
})
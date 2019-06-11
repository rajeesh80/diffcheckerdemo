({
	getRaces : function(component) {
        console.log('----RaceListHelper:Start----');
	//Steps in controller/helper class
	//1. Get Action (c.action refers to server side apex controller method)
	//2. Get parameters from view that needs to be passed(optional)
	//3. set callback function
	//4. if response from server side controller is good/valid, set the output on to the view variable.
	//5. enqueue action - js async
		var action = component.get('c.getRacesDB');//server side controller function call.
        action.setCallback(this, function(response){
                      		var state = response.getState();
                            if(component.isValid()&&state==="SUCCESS"){
                            	component.set('v.races',response.getReturnValue());    
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
        console.log('----RaceListHelper:End----');

    },
    addToList : function(component, event){
        console.log('inside addToList helper function: start');
        var race = event.getParam('race');
        var races = component.get("v.races");
        //There is no need to have a server side call. At this point we are referring to an object that is already committed to db,
      	//just add it the array at the top from client side code itself.
        //array.push puts the new value at the end of the list. using another jscript function to show it at the top.
        //races.push(race);
        races.unshift(race);
        console.log('race list refreshed'+races);
        component.set("v.races",races);
        console.log('addToList helper function finished.');
    },
 
})
({
    //deletes the task record
	deleteTask : function(cmp,taskId,rowIdx) {
		var action = cmp.get("c.deleteTask");
        
        action.setParams({
            "taskId":taskId
        });
        
        action.setCallback(this,function(resp){
            var state = resp.getState();
            
            //if SUCCESS, delete the task row from the table
            if(cmp.isValid() && state === 'SUCCESS'){
                cmp.find("taskTable").deleteRow(rowIdx);
            }
            else{
                console.log(resp.getError());
            }
        });
        
        $A.enqueueAction(action);
	},
    completeTasks : function(cmp){
        
        //Retrieve the selectedTask rows in the table using v.selectedRows of the Datatable Component
        var selectedTasks = cmp.find("taskTable").get("v.selectedRows");
        
        for(var i = 0;i < selectedTasks.length;i++){
            selectedTasks[i].Stage__c  = 'Completed';
            selectedTasks[i] = JSON.parse(JSON.stringify(selectedTasks[i]));
        }
        
        var action = cmp.get("c.markTasksAsCompleted");
        
        action.setParams({
            "tasks":selectedTasks
        });
        
        action.setCallback(this,function(resp){
            var state = resp.getState();
            //if SUCCESS, call the rerenderRows() to reflect the changes in the table
            if(cmp.isValid() && state === 'SUCCESS'){
                cmp.find("taskTable").rerenderRows();
            }
            else{
                console.log(resp.getError());
            }
        });
        
        $A.enqueueAction(action);
    },
    completeTask : function(cmp, task, index){
        //Hide the task modal once editing is done
        var action = cmp.get("c.upsertTask");
        var selectedProjId = cmp.get("v.projectId");
        
        if(selectedProjId){
            
            //set the Project lookup field of the task 
            task.Project__c = selectedProjId;
            task.Stage__c  = "Completed";
            
            action.setParams({
                "taskRec":task
            });
            
            action.setCallback(this,function(resp){
                var state = resp.getState();
                if(cmp.isValid() && state === 'SUCCESS'){
                    
                    // if operation is edit, then update the row in the table
                    cmp.find("taskTable").updateRow(index,task);                                         
                }
                else{
                    console.log(resp.getError());
                }
            });
            
            $A.enqueueAction(action);
        }
    },
    closeTaskModal : function(cmp){
        //Hide the task modal once editing is done
        cmp.find("taskEditModal").close();
        
        //Reset the temporary variables
        cmp.set("v.rowIndex",-1);
        
        //Reset the selectedTask
        cmp.set("v.selectedTask",{'sobjectType':'ldt_Task__c','Stage__c':'','Name':'','Project__c':'','Start_Date__c':'','Description__c':'','Due_Date__c':''});
    }
})
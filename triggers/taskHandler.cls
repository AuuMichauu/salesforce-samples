/*
Name: ClosedOpportunityTrigger
Object: Opportunity
Events: after insert and after update
Condition: Stage is Closed Won
Operation: Create a task:
Subject: Follow Up Test Task
WhatId: the opportunity ID (associates the task with the opportunity)
Bulkify the Apex trigger so that it can insert or update 200 or more opportunities
*/
trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    //Makes a List of relatedOpportunities ones that are the subject of trigger
	List<Opportunity> relatedOpp = [SELECT Id, StageName FROM Opportunity
        WHERE Id IN :Trigger.New];
    //Makes a empty list to store future tasks
    List<Task> tskList = new List<Task>();
    //Iterates over related task query list
    for (Opportunity opp : relatedOpp){
        if (opp.StageName == 'Closed Won'){
            Task tsk = new Task();
            tsk.Subject = 'Follow Up Test Task';
            tsk.WhatId = opp.Id;
            tskList.add(tsk);
        }
    }
    insert tskList;
}

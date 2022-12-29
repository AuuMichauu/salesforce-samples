//
public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> updWO) {
        //Generate a set of ID Cases that have their Repair or Routine maintenance status set to Closed
        Set<Id> maintenanceId = new Set<Id>();
        //Browse through Cases provided by Trigger that meet the criteria
        for (Case c : updWO){
            if (c.Type == 'Repair' || c.Type == 'Routine Maintenance'){
                if (c.Status == 'Closed'){
                    maintenanceId.add(c.Id);
                }
            }
        }
        //Based on input ID's 
        if(maintenanceId.size() > 0){
            //Placeholder for new Cases based on old Casess
            List<Case> newCases = new List<Case>();
            //A map that relates the ID and Case of case that is closed and meet the criteria
            Map<Id,Case> closedCases = new Map<Id,Case>([SELECT Id, Vehicle__c, Equipment__c, Product__c, ProductID, Equipment__r.Maintenance_Cycle__c,(SELECT Id,Equipment__c,Quantity__c FROM Equipment_Maintenance_Items__r) 
                                                         FROM Case WHERE Id IN :maintenanceId]);
            
            //A map that holds ID and agregated decimal of shortest maintenance cycle
            Map<Id,Decimal> maintenanceCycles = new Map<ID,Decimal>();
            
            //A placeholder for inner querry
            List<Equipment_Maintenance_Item__c> newEMI = new List<Equipment_Maintenance_Item__c>();
            
            Map<id,Equipment_Maintenance_Item__c> equip = new map<id,Equipment_Maintenance_Item__c>([Select ID, Equipment__c, Quantity__c,Equipment__r.id,Equipment__r.Maintenance_Cycle__c from Equipment_Maintenance_Item__c ]);
            
            //Select the maintenance requests with the 
            AggregateResult[] results = [SELECT Maintenance_Request__c, MIN(Equipment__r.Maintenance_Cycle__c)cycle 
                                         FROM Equipment_Maintenance_Item__c WHERE Maintenance_Request__c IN :maintenanceId 
                                         GROUP BY Maintenance_Request__c];
            for (AggregateResult ar : results){ 
                maintenanceCycles.put((Id) ar.get('Maintenance_Request__c'), (Decimal) ar.get('cycle'));
            }
            //A list of new cases
            for (Case c : closedCases.values()){
                Case newCase = new Case();
                newCase.Type = 'Routine Maintenance';
                newCase.Status = 'New';
                newCase.Vehicle__c = c.Vehicle__c;
                newCase.ParentId = c.Id;
                newCase.Date_Reported__c = Date.today();
                newCase.Subject = 'Routine Maintenance Request';
                newCase.Origin = 'Web';
                newCase.Equipment__c = c.Equipment__c;
                newCase.ProductId = c.ProductId;
                newCase.Product__c = c.Product__c;
                newCase.Date_Due__c = Date.today().addDays((Integer) maintenanceCycles.get(c.Id));
                newCases.add(newCase);
                //Iterate through inner query to get equipment maintenance items
                for(Equipment_Maintenance_Item__c emi : c.Equipment_Maintenance_Items__r ){
                    newEMI.add(new Equipment_Maintenance_Item__c(
                        Equipment__c = equip.get(emi.id).Equipment__c,
                        Maintenance_Request__c = c.id,
                        Quantity__c = equip.get(emi.id).Quantity__c));
                }
            }
            Database.insert(newCases, True);
            
            //Create connection between maintenance items and equipment items
            for(Case c2: newCases){
                for(Equipment_Maintenance_Item__c emi2 : newEMI){
                    if(c2.parentID == emi2.Maintenance_Request__c){
                        emi2.Maintenance_Request__c = c2.id;    
                    }
                }
            }
            insert newEMI;
        }
        
    }
}

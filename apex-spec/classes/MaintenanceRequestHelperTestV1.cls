@isTest
public with sharing class MaintenanceRequestHelperTestV1 {
    @isTest
    static void bulkMaintenanceTest(){
        // Create new test equipment item
        Product2 equip = new Product2(Name = 'Test Part', 
                                     Maintenance_Cycle__c = 20,
                                     Replacement_Part__c = true,
                                     lifespan_months__C = 1
                                     );
        Database.insert(equip);
        
        vehicle__c vehic = new vehicle__c(Name = 'Test Car');
        Database.insert(vehic);
        
        // Create new maintenance request cases placeholder
        List<Case> newMRL = new List<Case>();
        // Create 300 new maintenance request cases related with equipment
        for (Integer i = 0; i < 300; i++){
            Case newMR = new Case(Type = 'Repair',
                				  Status = 'New',
                                  Origin = 'Web',
                                  Subject = 'Test Case',
                                  Date_Reported__c = Date.today(),
                                  Vehicle__c = vehic.Id,
                                  Equipment__c = equip.Id);
                newMRL.add(newMR);
        }
        if(!newMRL.isEmpty()){
            Database.insert(newMRL);
        }
        
        //Create new maintenance request items placeholder
        List<Equipment_Maintenance_Item__c> newEMIL = new List<Equipment_Maintenance_Item__c>();
        //Create new maintenance request items
        for (Integer j = 0; j < 10; j++){
            Equipment_Maintenance_Item__c newEMI = new Equipment_Maintenance_Item__c(Equipment__c = equip.id,
                                                                                    Maintenance_Request__c = newMRL[j].id,
                                                                                    Quantity__c = 10);
            newEMIL.add(newEMI);
        }
        if(!newEMIL.isEmpty()){
            Database.insert(newEMIL);
        }
                
        List<Case> updCaseList = new List<Case>();
        for(Case c : [SELECT Id, Subject, Type, Status, Origin,
                   Vehicle__c, Equipment__c, Date_Reported__c,
                   Vehicle__r.Id, Vehicle__r.Name, Equipment__r.Id 
                   FROM Case WHERE Status = 'New']) {
            c.Status = 'Closed';
            updCaseList.add(c);
        }
        Test.startTest();
        Database.upsert(updCaseList);
        System.assertEquals(300, [SELECT count() FROM Case WHERE Type = 'Routine Maintenance' and Date_Reported__c = :Date.today()]);
        Test.stopTest();
        
    }
    @isTest
    static void positive(){
        product2 pd = new product2 (name = 'Test',
                                   Maintenance_Cycle__c = 10,
                                   Replacement_Part__c = true
                                   );
        Database.insert(pd);
        Case cParent = new Case (Subject = 'Test Case',
                                 Type = 'Repair',
                                 Origin = 'Web',
                                 Date_Reported__c = Date.today(),
                                 Status = 'Closed',
                                 Equipment__c = pd.id);
        Database.insert(cParent);
        Case cChild = new Case (Subject = 'Test Case',
                                 Type = 'Repair',
                                 Origin = 'Web',
                                 Date_Reported__c = Date.today(),
                                 Status = 'New',
                                 Equipment__c = pd.id,
                                 parentID = cParent.id);
        Database.insert(cChild);
        cParent.subject = 'Testing subject';
        Database.update(cParent);
        System.assertEquals(1, (Integer)[SELECT count() FROM Case WHERE parentId = :cParent.id]);
            
    }
}

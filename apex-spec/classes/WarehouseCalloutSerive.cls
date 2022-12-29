public with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts {
	
    //URL for external service REST callout
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    //A placeholder for list equipment that will be imported from external DB
    List<product2> impEquip = new List<product2>();
    
    public void execute (QueueableContext context){
        //Boiler plate for get from URL
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            // In order to get inside key - value pair we have to deserialize the received data
            for(Object equip: results) {
                Map<String, Object> j = (Map<String, Object>) equip;
                Product2 newEQT = new Product2();
                newEQT.Replacement_Part__c = True;
                newEQT.Name = (String) j.get('name');
                newEQT.Maintenance_Cycle__c = (Integer) j.get('maintenanceperiod');
                newEQT.Lifespan_Months__c = (Integer) j.get('lifespan');
                newEQT.Cost__c = (Decimal) j.get('lifespan');
                newEQT.Warehouse_SKU__c = (String) j.get('sku');
                newEQT.Current_Inventory__c = (Integer) j.get('quantity');
                impEquip.add(newEQT);
            }
            //If list is not empty update and insert the records
            if(!impEquip.isEmpty()){
                upsert impEquip;
                
                System.debug(impEquip);
            }
        }
    }
    
}

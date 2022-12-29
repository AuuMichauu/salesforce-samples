trigger MaintenanceRequest on Case (before update, after update) {
    
    if(Trigger.isAfter && Trigger.isUpdate){
        MaintenanceRequestHelper.updateWorkOrders(Trigger.New);
    }
}

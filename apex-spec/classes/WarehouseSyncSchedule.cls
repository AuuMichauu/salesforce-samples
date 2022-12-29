public with sharing class WarehouseSyncSchedule implements Schedulable {
    // A class that schedules the job
    // In order to set the proper time need to make anonymous callout to set the CRON_EXP         
    // String CRON_EXP = '0 0 1 ? * * *'; //This one sets the time to everyday at 1AM
    // ID jobID = System.schedule('WarehouseSyncScheduleJob', CRON_EXP, new WarehouseSyncSchedule());
    public void execute (SchedulableContext ctx) {
        System.enqueueJob(new WarehouseCalloutService());
    }
}

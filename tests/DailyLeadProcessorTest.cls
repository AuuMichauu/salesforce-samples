@isTest
private class DailyLeadProcessorTest {
    
    //CRON EXPRESION THAT SAYS MIDNIGHT EVERY DAY 
    private static string CRON_EXP = '0 0 0 ? * * *';
    
    @isTest
    private static void testSchedulableClass() {
        //Load test data
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 500; i++){
            Lead ld = new Lead(LastName = 'Testowski', Company = 'TestCo' + i);
            leads.add(ld);
        }
        insert leads;
        
        //Perform test
        Test.startTest();
        String jobId = System.schedule('Daily Processor', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        //Check results
        List<Lead> lds = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'];
        system.assertEquals(200, lds.size());
    }
}

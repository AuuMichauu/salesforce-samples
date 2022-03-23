@isTest
private class LeadProcessorTest {

    @isTest
    public static void testBatchClass(){
        //LOAD TEST DATA
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++){
            Lead ldd = new Lead(LastName='Potato' + ' ' + i, Company = 'Pokemon', LeadSource = 'XD');
            leads.add(ldd);
        }
        insert leads;
        //PERFORM TEST
        test.startTest();
        //Instance of a class
        LeadProcessor lp = new LeadProcessor();
        //Execute batch 
        Id batchId = Database.executeBatch(lp, 200);
        test.stopTest();
        
        //Check the result
      	List<Lead> testUpdatedLeads = [SELECT Id, Name FROM Lead WHERE LeadSource = 'Dreamforce'];
        system.assertEquals(200, testUpdatedLeads.size(), 'ERROR: At least 1 Lead record not updated correctly');
    }
}

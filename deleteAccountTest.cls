@isTest
public class TestAccountDeletion {
    @isTest static void TestDeleteAccountWithOneOpportunity() {
        //Test data setup
        //Create an account with an opportunity, and then try to delete it
        Account acc = new Account(Name = 'Test Testowski');
        insert acc;
        Opportunity opp = new Opportunity(Name = acc.Name + 'Opportunity',
                                         StageName = 'Prospecting',
                                         CloseDate = System.today().addMonths(1),
                                         AccountId = acc.Id);
        insert opp;
        //TEST DELETE
        Test.startTest();
        Database.DeleteResult result = Database.delete(acc, false);
        Test.stopTest();
        //Verify
        //In this case the deletation should have been stopped by the trigger
        //so lets verify that!
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.',
                             result.getErrors()[0].getMessage());
    }
}
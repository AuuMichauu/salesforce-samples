@IsTest
private class AccountManagerTest {
    @isTest 
    private static void testGetCaseById() {
        Id accId = createTestAccWithContacts();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Accounts/'
            + accId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account accCall = AccountManager.getAccount();
        // Verify results
        System.assertEquals('Test boy', accCall.name);
    }
 
    // Helper method
    private static Id createTestAccWithContacts() {
        // Create test Acc
        Account accTest = new Account(
            Name='Test boy');
        insert accTest;
        //Populate with contact
        Contact cntTest = new Contact(AccountId = accTest.id,
                                      LastName = accTest.Name + 'boy');
        insert cntTest;
        return accTest.Id;
    }          
}

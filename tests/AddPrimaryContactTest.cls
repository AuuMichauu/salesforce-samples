@isTest
public class AddPrimaryContactTest {

    @isTest
    private static void testQueableClass(){
        //Load test data
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 500; i++){
            Account acc = new Account(name = 'testAcc' + i);
            if ( i < 250){
                acc.BillingState = 'NY';
            }
            else {
                acc.BillingState = 'CA';
            }
            accounts.add(acc);
        }
        insert accounts;
        Contact contact = new Contact(FirstName = 'Ash', LastName = 'Keczap');
        insert contact;
        
        //Perform test
        Test.startTest();
        System.enqueueJob(new AddPrimaryContact(contact, 'CA'));
        Test.stopTest();
        
        // Check the result
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'CA'];
        System.assertEquals(200, contacts.size(), 'ERROR: Something went wrong incorrect amount of contacts');
    }
    

}

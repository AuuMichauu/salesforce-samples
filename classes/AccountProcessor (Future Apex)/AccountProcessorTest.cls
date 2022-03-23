@isTest
private class AccountProcessorTest {
	
    @isTest
    private static void countContactsTest(){
        
        //Load Test Data
        //Create 300 Accounts
        List<Account> accs = new List<Account>();
        
        for (Integer i = 0; i < 300; i++){
            Account acc = new Account(Name = 'Test Boy' +i);
            accs.add(acc);
            //Alternative Version accs.add(new Account(Name = 'Test Boy' + i));
        }
        insert accs;
        
        //Asign from 1 to 5 Contacts for each Account
        List<Contact> conts = new List<Contact>();
        List<ID> accountsIds = new List<ID>();
        for(Integer i = 0; i < accs.size(); i++){
            Account acc = accs[i];
            Integer randNumOf5 = Integer.valueOf(Math.ceil(Math.random() * 5));
            accountsIds.add(acc.Id);
            for (Integer j = 0; j < randNumOf5; j++){
                Contact cnt = new Contact(AccountId = acc.id,
                                          LastName = acc.Name + i);
                conts.add(cnt);
            }
        }
        insert conts;
        
        //Testing Area
        Test.startTest();
        	AccountProcessor.countContacts(accountsIds);
        Test.stopTest();
            
        
        //Check results
        List<Account> accounts = [SELECT Id, Number_of_Contacts__c FROM Account];
        for (Account acc : accounts){
            System.assert(acc.Number_of_Contacts__c > 0, 'ERROR: At least 1 Account record with incorect amount of Contacts');
        }
    }
}

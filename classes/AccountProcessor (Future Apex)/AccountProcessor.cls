/*Create an Apex class with a future method that accepts a List of Account IDs and updates a custom field on the Account object with the number of contacts associated to the Account. Write unit tests that achieve 100% code coverage for the class. Every hands-on challenge in this module asks you to create a test class.
Create a field on the Account object:
Label: Number Of Contacts
Name: Number_Of_Contacts
Type: Number
This field will hold the total number of Contacts for the Account
Create an Apex class:
Name: AccountProcessor
Method name: countContacts
The method must accept a List of Account IDs
The method must use the @future annotation
The method counts the number of Contact records associated to each Account ID passed to the method and updates the 'Number_Of_Contacts__c' field with this value
Create an Apex test class:
Name: AccountProcessorTest
The unit tests must cover all lines of code included in the AccountProcessor class, resulting in 100% code coverage.
Before verifying this challenge, run your test class at least once using the Developer Console Run All feature
*/
public without sharing class AccountProcessor {
	
    @future
    public static void countContacts(List<Id> accountsIds){
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) 
                                 FROM Account 
                                 WHERE Id IN :accountsIds];
       
        for(Account acc : accounts){
            acc.Number_of_Contacts__c = acc.Contacts.size();
        }
        
        update accounts;
    }
}

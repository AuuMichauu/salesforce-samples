/*
Create an Apex class:
Name: AddPrimaryContact
Interface: Queueable
Create a constructor for the class that accepts as its first argument a Contact sObject and a second argument as a string for the State abbreviation
The execute method must query for a maximum of 200 Accounts with the BillingState specified by the State abbreviation passed into the constructor and insert the Contact sObject record associated to each Account. Look at the sObject clone() method.
Create an Apex test class:
Name: AddPrimaryContactTest
In the test class, insert 50 Account records for BillingState NY and 50 Account records for BillingState CA
Create an instance of the AddPrimaryContact class, enqueue the job, and assert that a Contact record was inserted for each of the 50 Accounts with the BillingState of CA
The unit tests must cover all lines of code included in the AddPrimaryContact class, resulting in 100% code coverage
Before verifying this challenge, run your test class at least once using the Developer Console Run All feature
*/
public without sharing class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String state;
    //Constructor method that assigns variables to private variables of a class
    public AddPrimaryContact(Contact inputContact, String inputState) {
        this.contact = inputContact;
        this.state = inputState;
    }
    //Quable execute method
    public void execute(QueueableContext context){
        //Retrive Account records
        List<Account> accounts = [SELECT Id FROM Account WHERE BillingState = :this.state LIMIT 200];
        
        //Create an empty contacts list
        List<Contact> contacts = new List<Contact>();
        
        //Iterate through the Account records
        for (Account acc : accounts){
            
            //Copy (clone) the contact record and make the copy a child of the specific account record
            //Add to contact list
            Contact contactClone = this.contact.clone();
            contactClone.AccountId = acc.id;
            contacts.add(contactClone);
        }
        
        insert contacts;
        
    }
}

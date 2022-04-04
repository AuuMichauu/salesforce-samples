/*
* Create an Apex REST class that is accessible at /Accounts/<Account_ID>/contacts. 
* The service will return the account's ID and name plus the ID and name of all contacts associated with the account. 
* Write unit tests that achieve 100% code coverage for the class and run your Apex tests.
* */
@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the ID from between the accounts and concatcs
        String accId = request.requestURI.substringBetween('Accounts/','/contacts');
        Account result =  [SELECT Id, Name, (SELECT Id, Name FROM Contacts)
                           FROM Account
                           WHERE Id = :accId];
        return result;
    }
}

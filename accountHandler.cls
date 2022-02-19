/*
The method must accept an incoming string as a parameter, which will be used to create the Account name
The method must insert the account into the system and then return the record
The method must also accept an empty string, catch the failed DML and then return null
*/
public class AccountHandler {
    //Public method that expect string input as account name
    public static Account insertNewAccount(string name){
        //Assingn account type sObject to acc variable
        Account acc = new Account();
        //Access Name field of acc sObject
        acc.Name = name;
        //Attempt insertation of acc object
        //If suceed insert it
        try {
            insert acc;
        }
        //If fails catch strike an error
        catch (DmlException e) {
            System.debug('A DML exception occoured ' + e.getMessage());
            return null;
        }
        //Return the record
        return acc;
    }
}
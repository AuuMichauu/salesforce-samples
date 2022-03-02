/*
The method must accept two incoming strings as parameters
The method should then find any contact that has a last name matching the first string, and mailing postal code (API name: MailingPostalCode) matching the second string
The method should finally return a list of Contact records of type List that includes the ID and Name fields 
*/
public class ContactSearch {
    public static List<Contact> searchForContacts(string param1, string param2){
        List<Contact> cont = [SELECT Name from Contact
                          WHERE LastName =: param1 AND MailingPostalCode =: param2];
        system.debug(cont);
        return cont;
    }
}

/*
The method must accept an incoming string as a parameter
The method should then find any contact or lead that matches the string as part of either the first or last name
The method should finally use a return type of List<List< SObject>>
NOTE: Because SOSL indexes data for searching, you must create a Contact record and Lead record before checking this challenge. Both records must have the last name Smith. The challenge uses these records for the SOSL search
*/
public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(string param1){
        List<List<SObject>> querr = [FIND :param1 
                               IN NAME FIELDS
                               RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)];
        system.debug(querr);
        return querr;
    }
}

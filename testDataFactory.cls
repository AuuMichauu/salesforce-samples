@isTest
public class TestDataFactory {
    //A public test method that creates number accounts with opportunities based on input
    public static List<Account> createAccountsWithOpps(Integer numAcc, Integer numOppPerAcc){
        //An empty list to store future accounts
        List<Account> accs = new List<Account>();
        //Iterator that generates the required amount of Accounts and adds it to list
        for (Integer i = 0; i < numAcc; i++){
            Account acc = new Account(Name = 'Pukimon#' + i);
            accs.add(acc);
        }
        //Accounts bulk insertation
        insert accs;
        
        //An empty list to store future Opportunities
        List<Opportunity> opps = new List<Opportunity>();
        //Iterator that selects each acc for future generation of Opportunities
        for (Integer i = 0; i < accs.size(); i++){
            Account acc = accs[i];
            //Iterator that generates requested amount of Opportunities and adds it to list
            for (Integer j = 0; j < numOppPerAcc; j++){
                Opportunity opp = new Opportunity(Name = acc.Name + ' opukitunity',
                                                  AccountId = acc.Id,
                                                  CloseDate = System.today().addMonths(1),
                                                  StageName = 'Prospecting');
                opps.add(opp);
            }
            
            
        }
        //Bulk insertation of opportunities
        insert opps;
        //Return of accounts with assigned opportunities
        system.debug(accs);
        return accs;
    }
}
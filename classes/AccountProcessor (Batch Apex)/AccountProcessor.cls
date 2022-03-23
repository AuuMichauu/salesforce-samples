/*Create an Apex class:

Name: LeadProcessor
Interface: Database.Batchable
Use a QueryLocator in the start method to collect all Lead records in the org
The execute method must update all Lead records in the org with the LeadSource value of Dreamforce
Create an Apex test class:
Name: LeadProcessorTest
In the test class, insert 200 Lead records, execute the LeadProcessor Batch class and test that all Lead records were updated correctly
The unit tests must cover all lines of code included in the LeadProcessor class, resulting in 100% code coverage
Before verifying this challenge, run your test class at least once using the Developer Console Run All feature
*/

//Batch apex - exceed governor limits for infinite glory - use with care
public without sharing class LeadProcessor implements Database.Batchable<sObject> {
    Integer recordCount = 0;
	//Returns a query locator - that is collect all the records  up to 50 000 000 records :O
    public Database.QueryLocator start(Database.BatchableContext dbc) {
        return Database.getQueryLocator([SELECT Id, Name FROM Lead]);
    }
    
    //Create an actual list of leads spread the previously collected leads into smaller chunks
    public void execute(Database.BatchableContext dbc, List<Lead> leads) {
        for(Lead l : leads){
            l.LeadSource = 'Dreamforce';
        }
        update leads;
        recordCount = recordCount + leads.size();
    }
    //Finish up area - is needed to include  even if does nothing particullary 
    public void finish(Database.BatchableContext dbc) {
        system.debug('The amount of updated records was ' + recordCount);
    }
}

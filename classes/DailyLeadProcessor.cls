/*Create an Apex class:
Name: DailyLeadProcessor
Interface: Schedulable
The execute method must find the first 200 Lead records with a blank LeadSource field and update them with the LeadSource value of Dreamforce
Create an Apex test class:
Name: DailyLeadProcessorTest
In the test class, insert 200 Lead records, schedule the DailyLeadProcessor class to run and test that all Lead records were updated correctly
The unit tests must cover all lines of code included in the DailyLeadProcessor class, resulting in 100% code coverage.
Before verifying this challenge, run your test class at least once using the Developer Console Run All feature
*/
public without sharing class DailyLeadProcessor implements Schedulable {
	
    public void execute(SchedulableContext ctx) {
        //Get 200 Lead records with null leadsource value
        List<Lead> leads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];
        //Iterate over leads and replace null value with desired value
        for (Lead l : leads) {
            l.LeadSource = 'Dreamforce';
        }
        update leads;
    }
}

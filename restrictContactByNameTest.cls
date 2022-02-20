/*
 Create an Apex trigger on the Contact object
Name: RestrictContactByName
Code: RestrictContactByName
Name: TestRestrictContactByName
Goal: 100% test coverage
*/
@isTest
private class TestRestrictContactByName {
    //Test that tries to update a valid record
    @isTest static void updateAllowedNameWithWrong() {
        Contact cnt = new Contact(FirstName = 'Jon',
                                  LastName = 'Jonowski');
        insert cnt;
        
        //Limit start test
        Test.startTest();
        //Modifies the last name to forbidden value
        cnt.LastName = 'INVALIDNAME';
		Database.SaveResult resu = Database.update(cnt, false);
        //Limit stop test
        Test.stopTest();
        
        //Checks if errors occured
        System.assert(!resu.isSuccess());
        System.assert(resu.getErrors().size() > 0);
        System.assertEquals('The Last Name "' + cnt.LastName + '" is not allowed for DML',
                             resu.getErrors()[0].getMessage());
    }
    //Test that tries to imput invalid record
    @isTest static void insertNotAllowedName() {
        Contact cnt = new Contact(FirstName = 'George',
                                  LastName = 'INVALIDNAME');
        Test.startTest();
        Database.SaveResult resu = Database.insert(cnt, false);
        Test.stopTest();
        
        //Checks if errors occured
        System.assert(!resu.isSuccess());
        System.assert(resu.getErrors().size() > 0);
        System.assertEquals('The Last Name "' + cnt.LastName + '" is not allowed for DML',
                             resu.getErrors()[0].getMessage());
    }
}
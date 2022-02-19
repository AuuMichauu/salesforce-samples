/*
Name: VerifyDate
Code: Copy from GitHub
Place the unit tests in a separate test class:
Name: TestVerifyDate
Goal: 100% code coverage
Run your test class at least once
*/
@isTest
private class TestVerifyDate {
    
    //Checking today and yesterday
    @isTest static void pastDate() {
        //Todays date
        Date today = Date.today();
        //Yesterdays Date
    	Date yesterday = Date.today().addDays(-1);
        //Variable that keeps date of last day of current Year and month
        Date lastDayDate = Date.newInstance(today.year(), today.month(), Date.daysInMonth(today.year(), today.month()));
        
        //Test callout
        Date test = VerifyDate.CheckDates(today, yesterday);
        //Equality checkage
        system.assertEquals(lastDayDate, test);
    }
    //Checking today and tomorrow
    @isTest static void futureDateWithin30Days(){
        //Todays date
        Date today = Date.today();
        //Tomorrow date
        Date tomorrow = Date.today().addDays(1);
        
        //Test callout
        Date test = VerifyDate.CheckDates(today, tomorrow);
        //Equality checkage
        system.assertEquals(tomorrow, test);
    }
    //Checking today and 31 Days from today
    @isTest static void futureDatePast31Days(){
        //Todays date
        Date today = Date.today();
        //31 days from today
        Date fromToday31Days = today.addDays(31);
        //Variable that keeps date of last day of current year and month
        Date lastDayDate = Date.newInstance(today.year(), today.month(), Date.daysInMonth(today.year(), today.month()));
        
        //Test callout
        Date test = VerifyDate.CheckDates(today, fromToday31Days);
        //Equality check
        system.assertEquals(lastDayDate, test);
    }
}
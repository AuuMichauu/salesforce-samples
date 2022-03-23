@isTest
private class AnimalLocatorTest {
	
    @isTest
    static void animalLocatorTestMethod() {
        //Set mock - callout mock class
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        //Test area
        Test.startTest();
        	String actualOkResult = AnimalLocator.getAnimalNameById(1);
        Test.stopTest();
        	String expectedOkResult = 'chicken';
        
        system.assertEquals(expectedOkResult, actualOkResult, 'Oppsie daisy records do not match');
    }
}

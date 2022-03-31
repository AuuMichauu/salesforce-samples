@isTest
private class ParkLocatorTest {
    @isTest
    private static void ParkLocatorTesting() {
        //Method setup mock
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String country = 'Dodge States';
        List<String> expectedParks = new List<String>{'Blablador Land', 'Lala Land', 'LeLandee'};
        //Verify test values
        System.assertEquals(expectedParks, ParkLocator.country(country));
    }
}

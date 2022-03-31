/*
 * Generate a class using this using WSDL file (WSDL INPUT):
Name: ParkService (Tip: After you click the Parse WSDL button, change the Apex class name from parksServices to ParkService)
Class must be in public scope
Create a class:
Name: ParkLocator
Class must have a country method that uses the ParkService class
Method must return an array of available park names for a particular country passed to the web service (such as Germany, India, Japan, and United States)
Create a test class:
Name: ParkLocatorTest
Test class uses a mock class called ParkServiceMock to mock the callout response
Create unit tests:

Unit tests must cover all lines of code included in the ParkLocator class, resulting in 100% code coverage.
Run your test class at least once (via Run All tests the Developer Console) before attempting to verify this challenge.
*/
public without sharing class ParkLocator {
    //Method that instances method of WSDL imported class
    public static List<String> country(String country) {
        // Method instance
        ParkService.ParksImplPort prkSrvc = new ParkService.ParksImplPort();
        return prkSrvc.byCountry(country);
    }
}

/*
Create an Apex class:
Name: AnimalLocator
Method name: getAnimalNameById
The method must accept an Integer and return a String.
The method must call https://th-apex-http-callout.herokuapp.com/animals/id, using the ID passed into the method 
The method returns the value of the name property (i.e., the animal name)
Create a test class:
Name: AnimalLocatorTest
The test class uses a mock class called AnimalLocatorMock to mock the callout response
Create unit tests:
Unit tests must cover all lines of code included in the AnimalLocator class, resulting in 100% code coverage
Run your test class at least once (via Run All tests the Developer Console) before attempting to verify this challenge
*/
public without sharing class AnimalLocator {

    public static String getAnimalNameById(Integer animalId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        //Endpoint request + specific animal id - the request is based on that
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + animalId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        // Deserialize the JSON string into collections of primitive data types.
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        //Once we enter a specific id this gets us a object of Map of related to animal key
        Map<String, Object> animal = (Map<String, Object>) result.get('animal');
        //Gets the value of name key (object) and converts into string
        return string.valueOf(animal.get('name'));

    }
}

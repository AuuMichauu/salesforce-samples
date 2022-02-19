/* 
The generateStringArray method must return an array (or list) of strings
The method must accept an incoming Integer as a parameter, which will be used to determine the number of returned strings
The method must return a string value in the format Test n where n is the index of the current string in the array 
*/
public class StringArrayTest {
    // Public method that returns list of strings
    public static List<String> generateStringArray(Integer numberOfStrings) {
        //Creating new empty list to contain generated strings
		List<String> listOfStrings = new List<String>();
        // Iterate the numberOfStrings amount of times
        for (Integer i = 0; i < numberOfStrings; i++) {
            listOfStrings.add('Test ' + i);
        	}
        //Log to the console result
        system.debug(listOfStrings);
        //Return function value
        return listOfStrings;
        }
    }
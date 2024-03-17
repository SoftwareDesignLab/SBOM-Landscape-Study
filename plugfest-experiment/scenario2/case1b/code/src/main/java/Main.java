// com.fasterxml.jackson.core
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

// com.google.guava
import com.google.common.collect.Maps;
import org.opentest4j.AssertionFailedError;

// org.junit.jupiter
import static org.junit.jupiter.api.Assertions.assertNotEquals;

// Native Java
import java.util.HashMap;
import java.util.Map;

/**
 * <b>File:</b> Main.java
 * <p>
 * <b>Description: Read in JSON string and increment all values by 1, then return updated string</b>
 *
 * @author Derek Garcia
 */
public class Main {

    /**
     * Read JSON String to Map
     *
     * @param jsonString JSON string to parse
     * @return Map representation of the JSON string
     * @throws JsonProcessingException Error parsing the JSON String
     */
    public static Map<String, Integer> readJSONString(String jsonString) throws JsonProcessingException {
        var map = new ObjectMapper().readValue(jsonString, HashMap.class);
        Map<String, Integer> jsonMap = Maps.newHashMap();

        // convert to use Guava map
        for(var key : map.keySet()){
            assert key instanceof String;
            assert map.get(key) instanceof Integer;
            jsonMap.put((String) key, (Integer) map.get(key));
        }

        return jsonMap;
    }

    /**
     * Convert a Map to JSON string
     *
     * @param jsonMap JSON map to covert
     * @return JSON string representation of the map
     * @throws JsonProcessingException Error writing the JSON String
     */
    public static String mapToJSONString(Map<String, Integer> jsonMap) throws JsonProcessingException {
        return new ObjectMapper().writeValueAsString(jsonMap);
    }


    /**
     * Increment the given value by one
     *
     * @param value Value to increment
     * @return value + 1
     */
    public static int incrementOne(int value){
        return value += 1;
    }


    /**
     * Read JSON string, update values by 1, then return updated JSON string
     *
     * @param args arg[0] JSON string to update
     */
    // java -classpath ../../../lib/* Main.java '{\"foo\":1}'
    public static void main(String[] args) {

        try{
            // Assert args not empty
            assertNotEquals(0, args.length);
            // Read JSON String
            Map<String, Integer> jsonMap = readJSONString(args[0]);
            // Update values
            jsonMap.replaceAll((k, v) -> incrementOne(jsonMap.get(k)));
            // Write JSON String
            String resultJSON = mapToJSONString(jsonMap);
            // Print result
            System.out.println(resultJSON);

        } catch (JsonProcessingException e){
            // Error parsing JSON String
            System.err.println("Failed to parse JSON String. Ensure format is: \"{\\\"string\\\": int}\"");
            System.err.println(e.getMessage());
        } catch (IndexOutOfBoundsException | AssertionFailedError e){
            // No arguments given
            System.err.println(
                    "Please provide a json string in the following form: " +
                            "\"{\\\"string\\\": int, \\\"string\\\": int, ... }\"");
        }
    }
}
// com.fasterxml.jackson.core
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

// com.google.guava
import com.google.common.collect.Maps;

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
     */
    public static Map<String, Integer> readJSONString(String jsonString){

        Map<String, Integer> jsonMap = new HashMap<>();

        // remove open and close braces and split on comma
        String[] jsonContents = jsonString.substring(1, jsonString.length() - 1).split(",");

        // Split each key pair string and add to map
        for(String obj : jsonContents){
            String[] keyValue = obj.split(":");
            jsonMap.put(keyValue[0].strip(), Integer.parseInt(keyValue[1].strip()));
        }

        return jsonMap;
    }

    /**
     * Convert a Map to JSON string
     *
     * @param jsonMap JSON map to covert
     * @return JSON string representation of the map
     */
    public static String mapToJSONString(Map<String, Integer> jsonMap){
        StringBuilder jsonString = new StringBuilder().append("{");

        // Build each json key pair
        for(String key : jsonMap.keySet()){
            jsonString.append(key)
                    .append(":")
                    .append(jsonMap.get(key).toString())
                    .append(",");
        }

        // Replace trailing comma with closing brace
        jsonString.replace(jsonString.length() - 1, jsonString.length(), "}");

        return jsonString.toString();
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
    public static void main(String[] args) {

        try{
            // Read JSON String
            Map<String, Integer> jsonMap = readJSONString(args[0]);
            // Update values
            jsonMap.replaceAll((k, v) -> incrementOne(jsonMap.get(k)));
            // Write JSON String
            String resultJSON = mapToJSONString(jsonMap);
            // Print result
            System.out.println(resultJSON);

        } catch (IndexOutOfBoundsException e){
            // No arguments given
            System.err.println(
                    "Please provide a json string in the following form: " +
                    "\"{\\\"string\\\": int, \\\"string\\\": int, ... }\"");
        }
    }
}
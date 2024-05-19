public with sharing class JsonConvert {

    public static String toJson(Object obj) {
        return JSON.serialize(obj);
    }

    public static Object fromJson(String jsonString, Type targetType) {
        return JSON.deserialize(jsonString, targetType);
    }
}
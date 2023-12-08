import 'dart:convert';

formatHTML(String str) {
  String jsonString = str;
  if (isJsonString(jsonString)) {
    try {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      Map<String, dynamic> formattedData = {
        "describe": jsonMap["describe"] ?? "",
        "imgs": jsonMap["imgs"] ?? [],
      };
      return formattedData;
    } catch (e) {}
  } else {
    return {
      "describe": jsonString,
      "imgs": [],
    };
  }
}

bool isJsonString(String jsonString) {
  try {
    json.decode(jsonString);
    return true;
  } catch (e) {
    return false;
  }
}

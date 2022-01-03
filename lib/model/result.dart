class Result {
  dynamic data;
  String message;
  bool success;

  Result();

  Result.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      data = jsonMap['data'];
      message = jsonMap['message'];
      success = jsonMap['success'];
    } catch (e) {
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["data"] = data;
    map["message"] = message;
    map["success"] = success;
    return map;
  }
}

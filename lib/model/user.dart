class User {
  String id;
  String email;
  String name;
  String level;
  String password;
  String apiToken;
  String deviceToken;
  String createdAt;

  bool auth;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      email = jsonMap['email'].toString();
      name = jsonMap['name'].toString();
      level = jsonMap['level'].toString();
      apiToken = jsonMap['api_token'];
      deviceToken = jsonMap['device_token'];
      createdAt = jsonMap['created_at'];
    } catch (e) {
      id = '';
      email = '';
      name = '';
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["level"] = level;
    map["password"] = password;
    map["email"] = email;
    map["api_token"] = apiToken;
    if (createdAt != null) {
      map["device_token"] = deviceToken;
    }
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}

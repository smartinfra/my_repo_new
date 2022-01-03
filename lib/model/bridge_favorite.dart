// import '../models/restaurant_favorite.dart';
import 'package:sensor_viewer/model/bridge.dart';

class BridgeFavorite {
  String id;
  String bridgeId;
  String userId;
  Bridge bridge;

  BridgeFavorite();

  BridgeFavorite.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      bridgeId = jsonMap['bridge_id'].toString();
      userId = jsonMap['user_id'].toString();
      bridge = jsonMap['bridge'] != null
          ? Bridge.fromJSON(jsonMap['bridge'])
          : new Bridge();
    } catch (e) {
      id = '';
      bridgeId = '';
      userId = '';
      bridge = new Bridge();
      print(e);
    }
  }

  Map<String, dynamic> toMap() {
    return {};
  }
}

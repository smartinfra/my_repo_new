// import '../models/restaurant_favorite.dart';
import '../model/bridge_info.dart';
import '../model/list_item.dart';
import '../model/media.dart';

class Bridge {
  String id;
  String name;
  Media image;
  String address;
  String latitude;
  String longitude;

  String acceleration;
  String displacement;
  String sensorStatus;
  String volt;
  String temperature;
  String wetness;

  String superstructureType;
  String constructionYear;
  String managementAgency;
  String managementContact;
  String createdAt;
  String inspectionDate;
  String inspectionResult;
  String inspectionDateNext;
  String triggerValue;
  String sensorValue;
  String sensorText;
  String axisValue;
  static String axis_st = '';

  List<ListItem> dateList;
  List<ListItem> timeList;
  List<BridgeInfo> bridgeInfo;

  String uuid;
  bool isFavorite;

  Bridge();

  Bridge.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
          ? Media.fromJSON(jsonMap['media'][0])
          : new Media();
      address = jsonMap['address'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];

      acceleration = jsonMap['acceleration']; // 최대가속도
      displacement = jsonMap['displacement']; // 최대변위
      sensorStatus = jsonMap['sensor_status']; // 센서상태
      volt = jsonMap['volt']; // 전압
      temperature = jsonMap['temperature']; // 온도
      wetness = jsonMap['wetness']; // 습도

      superstructureType = jsonMap['superstructure_type'];
      constructionYear = jsonMap['construction_year'];
      managementAgency = jsonMap['management_agency'];
      managementContact = jsonMap['management_contact'];
      inspectionDate = jsonMap['inspection_date'];
      inspectionResult = jsonMap['inspection_result'];
      inspectionDateNext = jsonMap['inspection_date_next'];
      triggerValue = jsonMap['trigger_value'];
      sensorValue = jsonMap['sensor_value'];

      isFavorite = jsonMap['is_favorite'] == 1 ? true : false;

      switch (sensorValue) {
        case 'normal':
          sensorText = '정상모드';
          break;
        case 'low':
          sensorText = '저전력모드';
          break;
        case 'sleep':
          sensorText = '잠자기모드';
          break;
        default:
          sensorText = '-';
      }
      axisValue = jsonMap['axis_value'];
      // print("bridge axis : " + axisValue);
      dateList = jsonMap['datelist'] != null &&
              (jsonMap['datelist'] as List).length > 0
          ? List.from(jsonMap['datelist'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      timeList = jsonMap['timelist'] != null &&
              (jsonMap['timelist'] as List).length > 0
          ? List.from(jsonMap['timelist'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      bridgeInfo =
          jsonMap['infos'] != null && (jsonMap['infos'] as List).length > 0
              ? List.from(jsonMap['infos'])
                  .map((element) => BridgeInfo.fromJSON(element))
                  .toList()
              : [];
      createdAt = jsonMap['created_at'] != null ? jsonMap['created_at'] : '';
    } catch (e) {
      id = '';
      name = '';
      image = new Media();
      address = '';
      latitude = '0';
      longitude = '0';
      acceleration = '';
      displacement = '';
      sensorStatus = '';
      volt = '';
      temperature = '';
      wetness = '';
      superstructureType = '';
      constructionYear = '';
      managementAgency = '';
      inspectionDate = '';
      inspectionResult = '';
      inspectionDateNext = '';
      triggerValue = '';
      sensorValue = '';
      sensorText = '-';
      axisValue = '';
      dateList = [];
      timeList = [];
      bridgeInfo = [];
      createdAt = '';
      isFavorite = false;
      print(e);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'acceleration': acceleration,
      'displacement': displacement,
      'sensor_status': sensorStatus,
      'volt': volt,
      'temperature': temperature,
      'wetness': wetness,
      'superstructure_type': superstructureType,
      'construction_year': constructionYear,
      'management_agency': managementAgency,
      'inspection_date': inspectionDate,
      'inspection_result': inspectionResult,
      'inspection_date_next': inspectionDateNext,
      'trigger_value': triggerValue,
      'sensor_value': sensorValue,
      'axis_value': axisValue,
      'uuid': uuid,
      'is_favorite': isFavorite
    };
  }
}

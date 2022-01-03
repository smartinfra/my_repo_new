// import '../models/restaurant_favorite.dart';
import 'package:sensor_viewer/model/bridge.dart';
import 'package:sensor_viewer/model/list_item.dart';

class BridgeInfo {
  String bridgeId;
  String stime;
  String time;
  String pga;
  String pgd;
  String frequency;
  String volt;
  String temp;
  String wetness;
  List<ListItem> accData;
  List<ListItem> accData2;
  List<ListItem> accData3;
  List<ListItem> strainData;
  List<ListItem> strainData2;
  List<ListItem> strainData3;
  List<ListItem> dispData;
  List<ListItem> otherData;
  List<ListItem> otherData2;
  List<ListItem> otherData3;
  String infoacc;
  String infoacc2;
  String infoacc3;
  String infostrain;
  String infostrain2;
  String infostrain3;
  String infodisp;
  String infoother;
  String infoother2;
  String infoother3;

  Bridge bridge;
  String axis;

  BridgeInfo();

  BridgeInfo.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      bridgeId = jsonMap['bridge_id'].toString();
      stime = jsonMap['stime'].toString();
      pga = jsonMap['pga'].toString();
      pgd = jsonMap['pgd'].toString();
      frequency = jsonMap['frequency'].toString();
      volt = jsonMap['volt'].toString();
      temp = jsonMap['temp'].toString();
      wetness = jsonMap['wetness'].toString();
      accData = jsonMap['acc_data'] != null &&
              (jsonMap['acc_data'] as List).length > 0
          ? List.from(jsonMap['acc_data'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      accData2 = jsonMap['acc_data2'] != null &&
              (jsonMap['acc_data2'] as List).length > 0
          ? List.from(jsonMap['acc_data2'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      accData3 = jsonMap['acc_data3'] != null &&
              (jsonMap['acc_data3'] as List).length > 0
          ? List.from(jsonMap['acc_data3'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      strainData = jsonMap['strain_data'] != null &&
              (jsonMap['strain_data'] as List).length > 0
          ? List.from(jsonMap['strain_data'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      strainData2 = jsonMap['strain_data2'] != null &&
              (jsonMap['strain_data2'] as List).length > 0
          ? List.from(jsonMap['strain_data2'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      strainData3 = jsonMap['strain_data3'] != null &&
              (jsonMap['strain_data3'] as List).length > 0
          ? List.from(jsonMap['strain_data3'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      dispData = jsonMap['disp_data'] != null &&
              (jsonMap['disp_data'] as List).length > 0
          ? List.from(jsonMap['disp_data'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      otherData = jsonMap['other_data'] != null &&
              (jsonMap['other_data'] as List).length > 0
          ? List.from(jsonMap['other_data'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      otherData2 = jsonMap['other_data2'] != null &&
              (jsonMap['other_data2'] as List).length > 0
          ? List.from(jsonMap['other_data2'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      otherData3 = jsonMap['other_data3'] != null &&
              (jsonMap['other_data3'] as List).length > 0
          ? List.from(jsonMap['other_data3'])
              .map((element) => ListItem.fromJSON(element))
              .toList()
          : [];
      bridge = jsonMap['bridge'] != null
          ? Bridge.fromJSON(jsonMap['bridge'])
          : new Bridge();
      axis = bridge.axisValue;
      infoacc = jsonMap['info_acc'].toString();
      infoacc2 = jsonMap['info_acc2'].toString();
      infoacc3 = jsonMap['info_acc3'].toString();
      infostrain = jsonMap['info_strain'].toString();
      infostrain2 = jsonMap['info_strain2'].toString();
      infostrain3 = jsonMap['info_strain3'].toString();
      infodisp = jsonMap['info_disp'].toString();
      infoother = jsonMap['info_other'].toString();
      infoother2 = jsonMap['info_other2'].toString();
      infoother3 = jsonMap['info_other3'].toString();

      print("bridge inf axis : " + axis);
    } catch (e) {
      bridgeId = '';
      stime = '';
      pga = '';
      pgd = '';
      frequency = '';
      volt = '';
      temp = '';
      wetness = '';
      accData = [];
      accData2 = [];
      accData3 = [];
      strainData = [];
      strainData2 = [];
      strainData3 = [];
      dispData = [];
      otherData = [];
      otherData2 = [];
      otherData3 = [];
      bridge = new Bridge();
      axis = '';
      infoacc = '';
      infoacc2 = '';
      infoacc3 = '';
      infostrain = '';
      infostrain2 = '';
      infostrain3 = '';
      infodisp = '';
      infoother = '';
      infoother2 = '';
      infoother3 = '';
      print(e);
    }
  }

  Map<String, dynamic> toMap() {
    return {};
  }
}

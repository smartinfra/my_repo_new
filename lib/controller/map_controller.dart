import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/bridge.dart';

import '../helper/helper.dart';
import '../model/user.dart';
import '../repository/bridge_repository.dart' as repository;

class MapController extends ControllerMVC {
  User user = new User();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  // FirebaseMessaging _firebaseMessaging;
  OverlayEntry loader;

  Location location;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData locationData;
  double _latitude;
  double _longitude;

  String kakaomapUrl =
      '${GlobalConfiguration().getString('api_base_url')}kakaomap';
  String kakaomapBrowseUrl =
      '${GlobalConfiguration().getString('api_base_url')}kakaomap/browse';
  Bridge bridge = new Bridge();

  MapController() {
    loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    scaffoldKey = new GlobalKey<ScaffoldState>();
    location = Location();
  }

  void update(bridge) async {
    FocusScope.of(context).unfocus();
    Overlay.of(context).insert(loader);
    repository.update(bridge).then((value) {
      if (value != null) {
        Navigator.of(scaffoldKey.currentContext)
            .pushReplacementNamed('/BridgeManagePage');
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('예외사항이 발생하였습니다.'),
        ));
      }
    }).catchError((e) {
      loader.remove();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('교량수정시 오류가 발생하였습니다.'),
      ));
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });
  }

  String getKakaomapUrl({String address, String latitude, String longitude}) {
    print(Uri.encodeFull(this.kakaomapUrl +
        '?address=' +
        address +
        '&latitude=' +
        latitude +
        '&longitude=' +
        longitude +
        '&current=' +
        _latitude.toString() +
        '|' +
        _longitude.toString()));
    return Uri.encodeFull(this.kakaomapUrl +
        '?address=' +
        address +
        '&latitude=' +
        latitude +
        '&longitude=' +
        longitude +
        '&current=' +
        _latitude.toString() +
        '|' +
        _longitude.toString());
  }

  String getKakaomapBrowseUrl({Bridge bridge}) {
    print(Uri.encodeFull(this.kakaomapBrowseUrl +
        '?limit=20&latitude=' +
        bridge.latitude.toString() +
        '&longitude=' +
        bridge.longitude.toString()));

    return Uri.encodeFull(this.kakaomapBrowseUrl +
        '?limit=20&latitude=' +
        bridge.latitude.toString() +
        '&longitude=' +
        bridge.longitude.toString());
  }

  Future<void> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    try {
      locationData = await location.getLocation();
      _latitude = locationData.latitude;
      _longitude = locationData.longitude;
    } catch (e) {
      _latitude = 0;
      _longitude = 0;
    }
  }

  void goDetail(String id) {
    Bridge _bridge = new Bridge();
    _bridge.id = id;
    Navigator.of(scaffoldKey.currentContext)
        .pushNamed('/BridgePage', arguments: _bridge);
  }
}

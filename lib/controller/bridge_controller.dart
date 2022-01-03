import 'dart:io';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/list_item.dart';
import '../model/bridge_info.dart';
import '../model/bridge_favorite.dart';
import '../helper/Helper.dart';
import '../model/bridge.dart';
import '../repository/bridge_repository.dart' as repository;
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class BridgeController extends ControllerMVC {
  Bridge bridge = new Bridge();
  List<Bridge> bridges = <Bridge>[];
  List<Bridge> dangers = <Bridge>[];
  List<BridgeFavorite> favorites = <BridgeFavorite>[];
  List<BridgeInfo> infos = <BridgeInfo>[];
  List<BridgeInfo> trigger = <BridgeInfo>[];
  List<ListItem> triggerPga = [];
  List<ListItem> triggerPgd = [];
  List<ListItem> triggerFrequency = [];
  GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  bool isTempFavorite = false; // api 호출전에 사전에 즐겨찾기 유무 화면 처리

  ListItem selectedItem;
  List<DropdownMenuItem<ListItem>> dropDownMenuItems = List();

  ImagePicker picker = ImagePicker();
  File file;
  var bytes;
  bool uploaded = false;

  OverlayEntry loader;

  Location location;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData locationData;
  double currLatitude;
  double currLongitude;

  BridgeController() {
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.formKey = new GlobalKey<FormState>();
    location = Location();
    currLatitude = 0.0;
    currLongitude = 0.0;
  }

  void listenForBridge(Bridge bridge) async {
    final Stream<Bridge> stream = await repository.getBridges(bridge);
    stream.listen((Bridge _bridge) {
      setState(() => bridges.add(_bridge));
    }, onError: (a) {}, onDone: () {});
  }

  // 교량데이터 기반 교량 리스트
  void listenForBridgeInfo(Bridge bridge) async {
    final Stream<BridgeInfo> stream =
        await repository.getBridgeInfos(bridge, true); // true : bridge 목록만 가져옴
    stream.listen((BridgeInfo _info) {
      setState(() => infos.add(_info));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForBridgeDanger(Bridge bridge) async {
    bridge.inspectionResult = 'D'; // 위험상태
    final Stream<Bridge> stream = await repository.getBridges(bridge);
    stream.listen((Bridge _bridge) {
      setState(() => dangers.add(_bridge));
    }, onError: (a) {}, onDone: () {});
  }

  void listenForFavorites(Bridge bridge) async {
    final Stream<BridgeFavorite> stream =
        await repository.getBridgeFavorites(bridge);
    stream.listen((BridgeFavorite _favorite) {
      setState(() => favorites.add(_favorite));
    }, onError: (a) {}, onDone: () {});
  }

  void getBridge({String id}) async {
    final Stream<Bridge> stream = await repository.getBridge(id: id);
    stream.listen(
        (Bridge _bridge) {
          setState(() {
            bridge = _bridge;
          });
        },
        onError: (a) {},
        onDone: () {
          buildDropDownMenuItems(bridge.timeList);
        });
  }

  void buildDropDownMenuItems(List menuList) {
    // List<DropdownMenuItem<ListItem>> items = List();

    setState(() {
      dropDownMenuItems.add(
        DropdownMenuItem(
          child: Text('계측날짜 선택'),
          value: ListItem('', '계측날짜 선택'),
        ),
      );
    });

    if (menuList != null && menuList.length > 0) {
      for (ListItem listItem in menuList) {
        setState(() {
          dropDownMenuItems.add(
            DropdownMenuItem(
              child: Text(listItem.name),
              value: listItem,
            ),
          );
        });
      }
    }
    selectedItem = dropDownMenuItems[0].value;
  }

  void updateBridge(Bridge _bridge) async {
    repository.update(_bridge).then((value) {
      setState(() {
        // this.favorite = value;
        // restaurantFavorites.add(value);
      });
      // scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text('정상적으로 업데이트 되었습니다.'),
      // ));
    });
  }

  void updateFavorite(Bridge _bridge) async {
    setState(() {
      _bridge.isFavorite = isTempFavorite;
      isTempFavorite = isTempFavorite ? false : true;
    });

    repository.updateFavorite(_bridge).then((value) {
      this.getBridge(id: _bridge.id);
    });
  }

  void getBridgeInfo({String id, String date}) async {
    // 그래프 재호출

    // setState(() {
    //   trigger = [];
    //   triggerPga = [];
    //   triggerPgd = [];
    //   triggerFrequency = [];
    // });

    // if (date == null) date = '';
    final Stream<BridgeInfo> stream =
        await repository.getBridgeInfo(id: id, date: date);
    stream.listen(
        (BridgeInfo _info) {
          setState(() => trigger.add(_info));
        },
        onError: (a) {},
        onDone: () {
          setState(() {
            trigger.forEach((element) {
              var time = element.stime.toString().split(" ")[1];
              element.time = time;
              triggerPga.add(ListItem(element.pga, time));
              triggerPgd.add(ListItem(element.pgd, time));
              triggerFrequency.add(ListItem(element.frequency, time));
            });
          });
        });
  }

  void register() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.register(bridge).then((value) {
        if (value != null) {
          // 2단계 이전 페이지 이동(참고)
          // int count = 0;
          // Navigator.popUntil(scaffoldKey.currentContext, (route) {
          //   return count++ == 1;
          // });

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
          content: Text('교량등록시 오류가 발생하였습니다.'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
      ;
    }
  }

  void update() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.update(bridge).then((value) {
        if (value != null) {
          /*
          int count = 0;
          Navigator.popUntil(scaffoldKey.currentContext, (route) {
            return count++ == 1;
          }); */

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
      ;
    }
  }

  void delete(Bridge bridge) async {
    repository.delete(bridge).then((value) {
      Navigator.of(scaffoldKey.currentContext)
          .pushReplacementNamed('/BridgeManagePage');
    }).catchError((e) {
      // loader.remove();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('교량삭제시 오류가 발생하였습니다.'),
      ));
    }).whenComplete(() {
      // Helper.hideLoader(loader);
    });
  }

  Future<void> refreshBridges() async {
    bridges = <Bridge>[];
    listenForBridge(new Bridge());
  }

  void chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    bytes = await pickedFile.readAsBytes();
    setState(() {
      file = File(pickedFile.path);
    });
  }

  void startUpload() {
    String fileName = file.path.split('/').last;
    upload(fileName);
  }

  void upload(String fileName) async {
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

    // get file length
    var length = await file.length();

    // string to uri
    var uri = Uri.parse(
        '${GlobalConfiguration().getString('api_base_url')}uploads/store');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile =
        new http.MultipartFile('file', stream, length, filename: fileName);

    // uuid 정보 저장
    setState(() {
      bridge.uuid = Uuid().generateV4();
    });

    // add file to multipart
    request.files.add(multipartFile);
    request.fields['uuid'] = bridge.uuid;
    request.fields['field'] = "image";

    // send
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('uploaded !!!');
      setState(() {
        uploaded = true;
      });
    }
  }

  Future<void> getLocation({bool loadBridge}) async {
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
      setState(() {
        currLatitude = locationData.latitude;
        currLongitude = locationData.longitude;
      });

      if (loadBridge == true) {
        bridge.latitude = currLatitude.toString();
        bridge.longitude = currLongitude.toString();
        listenForBridge(bridge);
        listenForBridgeDanger(bridge);
      }
    } catch (e) {}
  }
}

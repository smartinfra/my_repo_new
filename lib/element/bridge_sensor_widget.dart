import 'package:charcode/charcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sensor_viewer/element/list_element_widget.dart';
import '../element/list_module_widget.dart';
import '../controller/bridge_controller.dart';
import '../model/bridge.dart';
import '../model/list_item.dart';
import '../data/my_colors.dart';
import '../widget/my_text.dart';

class BridgeSensorWidget extends StatefulWidget {
  final Bridge bridge;
  BridgeSensorWidget({Key key, this.bridge}) : super(key: key);

  @override
  BridgeSensorWidgetState createState() => new BridgeSensorWidgetState();
}

class BridgeSensorWidgetState extends StateMVC<BridgeSensorWidget> {
  BridgeController _con;

  BridgeSensorWidgetState() : super(BridgeController()) {
    _con = controller;
  }
  // List<ListItem> _triggerItems = [
  //   ListItem("30", "30mg"),
  //   ListItem("40", "40mg"),
  //   ListItem("50", "50mg"),
  //   ListItem("60", "60mg"),
  //   ListItem("70", "70mg"),
  //   ListItem("80", "80mg"),
  //   ListItem("90", "90mg"),
  //   ListItem("100", "100mg"),
  // ];

  List<ListItem> _sensorItems = [
    ListItem("normal", "정상모드"),
    ListItem("low", "저전력모드"),
    ListItem("sleep", "잠자기모드"),
  ];
  // List<ListItem> _axisItems = [
  //   ListItem("x", "x축"),
  //   ListItem("y", "y축"),
  //   ListItem("z", "z축"),
  // ];

  // List<DropdownMenuItem<ListItem>> _triggerMenuItems;
  List<DropdownMenuItem<ListItem>> _sensorMenuItems;
  // List<DropdownMenuItem<ListItem>> _axisMenuItems;

  // ListItem _selectTriggerItem;
  ListItem _selectSensorItem;
  // ListItem _selectAxisItem;

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _triggerMenuItems = buildDropDownMenuItems(_triggerItems);
    // _selectTriggerItem = _triggerMenuItems[0].value;

    _sensorMenuItems = buildDropDownMenuItems(_sensorItems);
    _selectSensorItem = _sensorMenuItems[0].value;

    // _axisMenuItems = buildDropDownMenuItems(_axisItems);
    // _selectAxisItem = _axisMenuItems[0].value;

    var _bridge = widget.bridge;
    var _triggerTextController = TextEditingController();
    _triggerTextController.text = _bridge.triggerValue;
    var _axisTextController = TextEditingController();
    _axisTextController.text = _bridge.axisValue;
    // if (_bridge.triggerValue != null && _bridge.triggerValue != '') {
    //   _selectTriggerItem = _triggerItems
    //       .firstWhere((element) => element.value == _bridge.triggerValue);
    // }
    if (_bridge.sensorValue != null && _bridge.sensorValue != '') {
      _selectSensorItem = _sensorItems
          .firstWhere((element) => element.value == _bridge.sensorValue);
    }
    // if (_bridge.axisValue != null && _bridge.axisValue != '') {
    //   _selectAxisItem = _axisItems
    //       .firstWhere((element) => element.value == _bridge.axisValue);
    // }
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("전원상태",
                style: MyText.headline(context).copyWith(
                    color: MyColors.grey_90, fontWeight: FontWeight.bold)),
            Container(height: 5),
            Column(children: <Widget>[
              Container(height: 10),
              ListElementWidget(
                title: "전압",
                desc: "${_bridge.volt}v",
              ),
            ]),
            Divider(),
            Text("온습도상태",
                style: MyText.headline(context).copyWith(
                    color: MyColors.grey_90, fontWeight: FontWeight.bold)),
            Container(height: 5),
            Column(children: <Widget>[
              Container(height: 10),
              ListElementWidget(
                title: "온도",
                desc: "${_bridge.temperature} " +
                    String.fromCharCodes([$deg, $C]),
              ),
              ListElementWidget(
                title: "습도",
                desc: "${_bridge.wetness}%",
              ),
            ]),
            Divider(),
            Text("모듈통신상태",
                style: MyText.headline(context).copyWith(
                    color: MyColors.grey_90, fontWeight: FontWeight.bold)),
            Container(height: 5),
            Column(
              children: <Widget>[
                Container(height: 10),
                ListModuleWidget(
                  title: "가속도1(ADXL 354)",
                  desc: "O",
                ),
                Container(height: 10),
                ListModuleWidget(
                  title: "가속도2(ADXL 354)",
                  desc: "O",
                ),
                Container(height: 10),
                ListModuleWidget(
                  title: "가속도3(ADXL 354)",
                  desc: "O",
                ),
                Container(height: 10),
                ListModuleWidget(
                  title: "변형률 게이지1",
                  desc: "O",
                ),
                Container(height: 10),
                ListModuleWidget(
                  title: "변형률 게이지2",
                  desc: "O",
                ),
                Container(height: 10),
                ListModuleWidget(
                  title: "변형률 게이지3",
                  desc: "O",
                ),
                Container(height: 10),
              ],
            ),
            Divider(),
            Text("설정변경",
                style: MyText.headline(context).copyWith(
                    color: MyColors.grey_90, fontWeight: FontWeight.bold)),
            Container(height: 5),
            Column(children: <Widget>[
              Container(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text('트리거크기 (mg)'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8),
                          child: TextField(
                            // TextField(initialValue: _bridge.triggerValue),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp('[0-9]')),
                            ],
                            controller: _triggerTextController,
                            onChanged: (text) {
                              _bridge.triggerValue = text;
                              _con.updateBridge(_bridge);
                            },
                          ),
                        )
                      ],
                    ),
                    // child: Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   child: DropdownButton<ListItem>(
                    //       value: _selectTriggerItem,
                    //       items: _triggerMenuItems,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _selectTriggerItem = value;
                    //           // print(value.value);
                    //           _bridge.triggerValue = value.value;
                    //           _con.updateBridge(_bridge);
                    //           showSnackBar();
                    //         });
                    //       }),
                    // ),
                  ),
                ],
              ),
            ]),
            Container(height: 5),
            Column(children: <Widget>[
              Container(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text('센서모드변경'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<ListItem>(
                          value: _selectSensorItem,
                          items: _sensorMenuItems,
                          onChanged: (value) {
                            setState(() {
                              _selectSensorItem = value;
                              // print(value.value);
                              _bridge.sensorValue = value.value;
                              _con.updateBridge(_bridge);
                              showSnackBar();
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ]),
            Container(height: 5),
            Column(children: <Widget>[
              Container(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text('트리거시간 (ms)'),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(8),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp('[0-9]')),
                            ],
                            controller: _axisTextController,
                            onChanged: (text) {
                              _bridge.axisValue = text;
                              _con.updateBridge(_bridge);
                            },
                          ),
                        )
                      ],
                    ),
                    // child: Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   child: DropdownButton<ListItem>(
                    //       value: _selectAxisItem,
                    //       items: _axisMenuItems,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           _selectAxisItem = value;
                    //           //print(value.value);
                    //           _bridge.axisValue = value.value;
                    //           Bridge.axis_st = value.value;
                    //           _con.updateBridge(_bridge);
                    //           showSnackBar();
                    //         });
                    //       }),
                    // ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }

  void showSnackBar() {
    final snackBar = new SnackBar(
      duration: const Duration(seconds: 1),
      content: new Text('정상적으로 업데이트 되었습니다!'),
      // action: new SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     // Some code to undo the change!
      //   },
      // ),
    );

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

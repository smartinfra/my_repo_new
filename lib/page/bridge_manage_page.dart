import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sensor_viewer/model/bridge.dart';
import '../controller/bridge_controller.dart';
import '../data/dummy.dart';
import '../element/bridge_manage_widget.dart';
import '../model/people.dart';
import '../widget/toolbar.dart';

class BridgeManagePage extends StatefulWidget {
  BridgeManagePage();

  @override
  BridgeManagePageState createState() => new BridgeManagePageState();
}

class BridgeManagePageState extends StateMVC<BridgeManagePage> {
  BuildContext context;

  BridgeController _con;

  BridgeManagePageState() : super(BridgeController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForBridge(new Bridge());
    super.initState();
  }

  void onDeleteClick(BuildContext context, Bridge bridge) {
    showAlertDialog(context, bridge);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        title: Text('교량관리'),
        backgroundColor: Colors.blueGrey[600],
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushNamed('/DashboardPage');
            }),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.search),
          //   onPressed: () {},
          // ), // overflow menu
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/BridgeRegisterPage', arguments: new Bridge());
            },
          ), // overflow menu
        ],
        centerTitle: true,
      ),
      body: BridgeManageWidget(_con.bridges, onDeleteClick).getView(),
    );
  }

  void showAlertDialog(BuildContext context, Bridge bridge) async {
    String result = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('교량삭제'),
          content: Text("${bridge.name} 교량을 삭제하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.pop(context, "Cancel");
                _con.delete(bridge);
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context, "Cancel");
              },
            ),
          ],
        );
      },
    );
  }
}

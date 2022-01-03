import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:sensor_viewer/model/bridge.dart';
// import 'package:sensor_viewer/repository/bridge_repository.dart';
import '../element/chart_line2_widget.dart';
import '../model/bridge_info.dart';
import '../element/button_contact_widget.dart';
import '../element/chart_line_widget.dart';
import '../widget/my_text.dart';

class BridgeTriggerPage extends StatefulWidget {
  final BridgeInfo trigger;
  BridgeTriggerPage({Key key, this.trigger}) : super(key: key);

  @override
  BridgeTriggerPageState createState() => new BridgeTriggerPageState();
}

class BridgeTriggerPageState extends State<BridgeTriggerPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  //ScrollController _scrollController;
  String formattedDate = '';
  String selectAxisItem = '';
  var axisValue = '';
  dynamic accData;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    //_scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    //_scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void recall() {
    // await getBridge(id: widget.trigger.bridge.id);
    // getBridge(id: widget.trigger.bridge.id);
    // getBridgeInfo(
    //     id: widget.trigger.bridge.id,
    //     date: widget.trigger.stime.substring(0, 11));
    // (Bridge.axis_st == '') ? axisValue = widget.trigger.bridge.axisValue : axisValue = Bridge.axis_st;

    // // print(widget.trigger.bridge.id);
    // // print(widget.trigger.stime.substring(0, 11));
    // print("axis : " + axisValue);
    //   if (axisValue == 'x') {
    //     accData = widget.trigger.accData;
    //   } else if (axisValue == 'y') {
    //     accData = widget.trigger.accData2;
    //   } else if (axisValue == 'z') {
    //     accData = widget.trigger.accData3;
    //   } else {
    //     print("axis : " + axisValue);
    //   }
  }

  @override
  Widget build(BuildContext context) {
    recall();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: NestedScrollView(
        //controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScroller) {
          return <Widget>[
            SliverAppBar(
              // title: Text('08/02 17:00:02'),
              // title: Text('${widget.trigger.bridge.name} - 트리거상세'),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.trigger.bridge.name != null
                        ? widget.trigger.bridge.name
                        : '',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  Text(
                    widget.trigger.stime,
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  )
                ],
              ),
              pinned: true,
              floating: true,
              backgroundColor: Colors.blueGrey[600],
              // leading: IconButton(
              //     icon: const Icon(Icons.menu),
              //     onPressed: () {
              //       // Navigator.pop(context);
              //     }),
              actions: <Widget>[
                // IconButton(
                //   icon: const Icon(Icons.search),
                //   onPressed: () {},
                // ), // overflow menu
                // PopupMenuButton<String>(
                //   onSelected: (String value) {},
                //   itemBuilder: (context) => [
                //     PopupMenuItem(
                //       value: "Settings",
                //       child: Text("Settings"),
                //     ),
                //   ],
                // )
              ],
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                labelStyle: MyText.subhead(context)
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                unselectedLabelColor: Colors.grey[400],
                tabs: [
                  // Tab(text: "신호영역"),
                  // Tab(text: "주파수영역"),
                  Tab(text: "가속도"),
                  Tab(text: "변형률"),
                  Tab(text: "변위"),
                  Tab(text: "주파수"),
                ],
                isScrollable: false,
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(height: 30),
                  ChartLineWidget.withData(
                      "가속도 X (" + widget.trigger.infoacc + ")",
                      widget.trigger.accData),
                  Container(height: 30),
                  ChartLineWidget.withData(
                      "가속도 Y (" + widget.trigger.infoacc2 + ")",
                      widget.trigger.accData2),
                  Container(height: 30),
                  ChartLineWidget.withData(
                      "가속도 Z (" + widget.trigger.infoacc3 + ")",
                      widget.trigger.accData3),
                  Container(height: 30),
                  ButtonContactWidget(
                      contact: widget.trigger.bridge.managementContact),
                  Container(height: 30),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(height: 30),
                  ChartLineWidget.withData(
                      "변형률 Ch1 (" + widget.trigger.infostrain + ")",
                      widget.trigger.strainData),
                  Container(height: 30),
                  ChartLineWidget.withData(
                      "변형률 Ch2 (" + widget.trigger.infostrain2 + ")",
                      widget.trigger.strainData2),
                  Container(height: 30),
                  ChartLineWidget.withData(
                      "변형률 Ch3 (" + widget.trigger.infostrain3 + ")",
                      widget.trigger.strainData3),
                  Container(height: 30),
                  ButtonContactWidget(
                      contact: widget.trigger.bridge.managementContact),
                  Container(height: 30),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ChartLineWidget.withData(
                      "변위 (" + widget.trigger.infodisp + ")",
                      widget.trigger.dispData),
                  Container(height: 30),
                  ButtonContactWidget(
                      contact: widget.trigger.bridge.managementContact),
                  Container(height: 30),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(height: 30),
                  ChartLine2Widget.withData(
                      "주파수 X (" + widget.trigger.infoother + ")",
                      widget.trigger.otherData),
                  Container(height: 30),
                  ChartLine2Widget.withData(
                      "주파수 Y (" + widget.trigger.infoother2 + ")",
                      widget.trigger.otherData2),
                  Container(height: 30),
                  ChartLine2Widget.withData(
                      "주파수 Z (" + widget.trigger.infoother3 + ")",
                      widget.trigger.otherData3),
                  Container(height: 30),
                  ButtonContactWidget(
                      contact: widget.trigger.bridge.managementContact),
                  Container(height: 30),
                ],
              ),
            ),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

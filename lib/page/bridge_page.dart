import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/list_item.dart';
import '../controller/bridge_controller.dart';
import '../utils/tools.dart';
import '../model/bridge.dart';
import '../element/bridge_sensor_widget.dart';
import '../element/chart_bar_widget.dart';
import '../element/bridge_detail_widget.dart';
import '../model/image_obj.dart';
import '../widget/my_text.dart';

class BridgePage extends StatefulWidget {
  final Bridge bridge;

  BridgePage({Key key, this.bridge}) : super(key: key);

  @override
  BridgePageState createState() => new BridgePageState();
}

class BridgePageState extends StateMVC<BridgePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  BuildContext _scaffoldCtx;

  // DateFormat dateFormat = DateFormat("yyyy년 MM월 d일");
  DateFormat dateFormat = DateFormat("MM월 d일");
  var selectedDate;
  var selectedDateFormated;
  String date = "-";
  Bridge _bridge = new Bridge();

  BridgeController _con;

  BridgePageState() : super(BridgeController()) {
    _con = controller;
  }

  void onItemClick(int index, ImageObj obj) {
    // print('aaaaaaaaaaaaaaaaaaadfasdf');
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    selectedDateFormated = dateFormat.format(DateTime.now());
    selectedDate = DateTime.now();

    var date = selectedDate.toString().split(" ")[0];
    // _con.getBridgeInfo(id: widget.bridge.id, date: '2020-08-19');
    _con.getBridge(id: widget.bridge.id);
    _con.getBridgeInfo(id: widget.bridge.id, date: date);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bridge = _con.bridge;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _bridge?.name != null
          ? NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScroller) {
                return <Widget>[
                  SliverAppBar(
                    // title: Text('08/02 17:00:02'),
                    title: Text(_bridge.name),
                    pinned: true,
                    floating: true,
                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/DashboardPage');
                        }),
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
                      labelStyle: MyText.subhead(context).copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      unselectedLabelColor: Colors.grey[400],
                      tabs: [
                        Tab(text: "교량정보"),
                        Tab(text: "트리거조회"),
                        Tab(text: "센서상태"),
                      ],
                      controller: _tabController,
                    ),
                  )
                ];
              },
              body: TabBarView(
                children: [
                  BridgeDetailWidget(bridge: _bridge),
                  Column(
                    children: <Widget>[
                      /* 달력선택방식
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          // child: RaisedButton(
                          //   onPressed: callDatePicker,
                          //   color: Colors.blueAccent,
                          //   child: new Text(selectedDateFormated,
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                          child: Row(
                            children: [
                              OutlineButton(
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today),
                                    SizedBox(width: 3),
                                    Text(selectedDateFormated),
                                  ],
                                ),
                                onPressed: callDatePicker,
                              ),
                            ],
                          ),
                        ),
                      ), */

                      // dropdown 방식
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: DropdownButton<ListItem>(
                            value: _con.selectedItem,
                            items: _con.dropDownMenuItems,
                            onChanged: (value) {
                              // print(value.value);
                              loadData(value);
                            }),
                      ),
                      ChartBarWidget.withData(
                          _con.trigger, _con.triggerPga, _con.triggerPgd),
                    ],
                  ),
                  BridgeSensorWidget(bridge: _bridge),
                ],
                controller: _tabController,
              ),
            )
          : Container(),
    );
  }

  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      selectedDateFormated = dateFormat.format(order);
      selectedDate = order;

      // 초기화
      _con.trigger = [];
      _con.triggerPga = [];
      _con.triggerPgd = [];
      _con.triggerFrequency = [];

      _con.getBridgeInfo(
          id: widget.bridge.id, date: selectedDate.toString().split(" ")[0]);
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      locale: Locale('ko'),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  void loadData(item) async {
    setState(() {
      _con.selectedItem = item;

      // 초기화
      _con.trigger = [];
      _con.triggerPga = [];
      _con.triggerPgd = [];
      _con.triggerFrequency = [];

      _con.getBridgeInfo(id: widget.bridge.id, date: item.value);
    });
  }
}

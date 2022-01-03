import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sensor_viewer/element/bridge_favorite_widget.dart';
import '../model/bridge.dart';
import '../controller/bridge_controller.dart';
import '../element/bridge_list_widget.dart';
import '../widget/my_text.dart';
import '../repository/user_repository.dart' as userRepo;

class DashboardPage extends StatefulWidget {
  DashboardPage();

  @override
  DashboardPageState createState() => new DashboardPageState();
}

class DashboardPageState extends StateMVC<DashboardPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  String formattedDate = '';

  BridgeController _con;

  DashboardPageState() : super(BridgeController()) {
    _con = controller;
  }

  void onItemClick(int index, Bridge bridge) {
    Navigator.of(context).pushNamed('/BridgePage', arguments: bridge);
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _con.getLocation(loadBridge: true);
    // _con.listenForBridge(new Bridge());
    _con.listenForFavorites(new Bridge());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  /* 타이머
  String myTimer() {
    Timer.periodic(new Duration(seconds: 1), (timer) {
      formattedDate = DateFormat('MM/dd HH:mm:ss ').format(DateTime.now());
      print(formattedDate);
      // debugPrint(timer.tick.toString());
    });
    print(formattedDate);
    return formattedDate;
  }
  */

  @override
  Widget build(BuildContext context) {
    formattedDate = DateFormat('MM/dd HH:mm:ss ').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScroller) {
          return <Widget>[
            SliverAppBar(
              // title: Text('08/02 17:00:02'),
              title: Row(
                children: [
                  Text(formattedDate),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/DashboardPage');
                    },
                  )
                ],
              ),
              pinned: true,
              floating: true,
              backgroundColor: Colors.blueGrey[600],
              automaticallyImplyLeading: false,
              // leading: IconButton(
              //     icon: const Icon(Icons.menu),
              //     onPressed: () {
              //       // Navigator.pop(context);
              //     }),
              actions: <Widget>[
                _con.currLatitude > 0 && _con.currLongitude > 0
                    ? IconButton(
                        icon: const Icon(Icons.map),
                        onPressed: () {
                          Bridge _bridge = new Bridge();
                          _bridge.latitude = _con.currLatitude.toString();
                          _bridge.longitude = _con.currLongitude.toString();
                          _bridge.name = '주변교량';
                          Navigator.of(context)
                              .pushNamed('/MapBrowsePage', arguments: _bridge);
                          // Navigator.of(context).pushNamed('/MapSearchPage');
                        },
                      )
                    : Container(), // overflow menu
                // 배포모드
                kReleaseMode
                    ? PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'profile') {
                            Navigator.of(context).pushNamed('/ProfilePage');
                          } else if (value == 'bridgeManage') {
                            Navigator.of(context)
                                .pushNamed('/BridgeManagePage');
                          } else if (value == 'logout') {
                            userRepo.logout().then((value) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/LoginPage',
                                  (Route<dynamic> route) => false);
                            });
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: "profile",
                            child: Text("프로필"),
                          ),
                          PopupMenuItem(
                            value: "logout",
                            child: Text("로그아웃"),
                          ),
                        ],
                      )
                    // 개발모드
                    : PopupMenuButton<String>(
                        onSelected: (String value) {
                          if (value == 'profile') {
                            Navigator.of(context).pushNamed('/ProfilePage');
                          } else if (value == 'bridgeManage') {
                            Navigator.of(context)
                                .pushNamed('/BridgeManagePage');
                          } else if (value == 'logout') {
                            userRepo.logout().then((value) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/LoginPage',
                                  (Route<dynamic> route) => false);
                            });
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: "bridgeManage",
                            child: Text("교량관리"),
                          ),
                          PopupMenuItem(
                            value: "profile",
                            child: Text("프로필"),
                          ),
                          PopupMenuItem(
                            value: "logout",
                            child: Text("로그아웃"),
                          ),
                        ],
                      )
              ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                labelStyle: MyText.subhead(context)
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                unselectedLabelColor: Colors.grey[400],
                tabs: [
                  Tab(text: "즐겨찾기"),
                  Tab(text: "주변교량"),
                  Tab(text: "위험교량"),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: [
            BridgeFavoriteWidget(_con.favorites, onItemClick).getView(),
            BridgeListWidget(_con.bridges, onItemClick).getView(),
            BridgeListWidget(_con.dangers, onItemClick).getView()
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sensor_viewer/controller/bridge_controller.dart';
import '../data/img.dart';
import '../data/my_colors.dart';
import '../element/list_element_widget.dart';
import '../model/bridge.dart';
import '../widget/my_text.dart';

/*
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
*/

class BridgeDetailWidget extends StatefulWidget {
  final Bridge bridge;

  BridgeDetailWidget({Key key, this.bridge}) : super(key: key);

  @override
  BridgeDetailWidgetState createState() => new BridgeDetailWidgetState();
}

class BridgeDetailWidgetState extends StateMVC<BridgeDetailWidget> {
  BridgeController _con;
  BridgeDetailWidgetState() : super(BridgeController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.isTempFavorite = widget.bridge.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    var _bridge = widget.bridge;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 200.0,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: CachedNetworkImage(
                    imageUrl: _bridge.image.thumb, fit: BoxFit.cover),
              ),
              actions: <Widget>[
                // IconButton(
                //   icon: Icon(Icons.share),
                //   onPressed: () {},
                // ), // overflow menu
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text(_bridge.name,
                //     style: MyText.headline(context).copyWith(
                //         color: MyColors.grey_90, fontWeight: FontWeight.bold)),
                // Container(height: 5),
                Divider(),
                Column(
                  children: <Widget>[
                    Container(height: 10),
                    ListElementWidget(
                      title: "상부구조형식",
                      desc: "${_bridge.superstructureType}",
                    ),
                    Container(height: 10),
                    ListElementWidget(
                      title: "교량준공연도",
                      desc: "${_bridge.constructionYear}",
                    ),
                    Container(height: 10),
                    ListElementWidget(
                      title: "최종안전점검일자",
                      desc: "${_bridge.inspectionDate}",
                    ),
                    Container(height: 10),
                    ListElementWidget(
                      title: "최종안전점검결과",
                      desc: "${_bridge.inspectionResult}",
                    ),
                    Container(height: 10),
                    ListElementWidget(
                      title: "다음 안전진단예정일",
                      desc: _bridge.inspectionDateNext != ''
                          ? "${_bridge.inspectionDateNext}"
                          : "-",
                    ),
                    Container(height: 10),
                    ListElementWidget(
                      title: "관리기관명",
                      desc: "${_bridge.managementAgency}",
                    ),
                    Container(height: 10),
                    ListElementWidget(
                      title: "관리기관연락처",
                      desc: "${_bridge.managementContact}",
                    ),
                    Container(height: 10),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_bridge.timeList.length > 0) {
            _con.updateFavorite(_bridge);
          } else {
            final snackBar = SnackBar(
              content: Text('데이터가 등록되지 않는 교량은\n즐겨찾기 할 수 없습니다.'),
              action: SnackBarAction(
                label: '닫기',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        tooltip: '즐겨찾기',
        child: Icon(Icons.star),
        backgroundColor: _con.isTempFavorite ? Colors.pink : Colors.grey,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

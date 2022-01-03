import 'package:flutter/material.dart';
import '../model/bridge_info.dart';
import '../element/bridge_search_widget.dart';
import '../controller/bridge_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/bridge.dart';

class MapSearchPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  MapSearchPage({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _MapSearchPageState createState() => _MapSearchPageState();
}

class _MapSearchPageState extends StateMVC<MapSearchPage> {
  String address = '';

  BridgeController _con;
  // List<Bridge> searchResult = <Bridge>[];
  List<BridgeInfo> searchResult = <BridgeInfo>[];
  TextEditingController cont = new TextEditingController();

  _MapSearchPageState() : super(BridgeController()) {
    _con = controller;
  }

  @override
  void initState() {
    // _con.listenForBridge(new Bridge());
    _con.listenForBridgeInfo(new Bridge());
    // searchResult = _con.bridges;
    searchResult = _con.infos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(_con.bridges);
    return Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('교량검색'),
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
            // IconButton(
            //   icon: const Icon(Icons.add),
            //   onPressed: () {
            //     Navigator.of(context)
            //         .pushNamed('/BridgeRegisterPage', arguments: Bridge());
            //   },
            // ), // overflow menu
          ],
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Container(
            // color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: cont,
                    decoration: InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      cont.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: BridgeSearchWidget(searchResult).getView(),
          )
        ]));
  }

  void onSearchTextChanged(String text) {
    setState(() {
      searchResult = _con.infos
          .where((element) =>
              element.bridge.name.contains(text) ||
              element.bridge.address.contains(text))
          .toList();
    });

    // _searchResult.clear();
    // if (text.isEmpty) {
    //   setState(() {});
    //   return;
    // }

    // _userDetails.forEach((userDetail) {
    //   if (userDetail.firstName.contains(text) ||
    //       userDetail.lastName.contains(text)) _searchResult.add(userDetail);
    // });

    // setState(() {});
  }
}

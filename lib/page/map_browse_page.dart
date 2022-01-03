import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:global_configuration/global_configuration.dart';
import '../controller/map_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../model/bridge.dart';

class MapBrowsePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  final Bridge bridge;

  MapBrowsePage({Key key, this.parentScaffoldKey, this.bridge})
      : super(key: key);

  @override
  _MapBrowsePageState createState() => _MapBrowsePageState();
}

class _MapBrowsePageState extends StateMVC<MapBrowsePage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String address = '';

  MapController _con;

  _MapBrowsePageState() : super(MapController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: _con.getKakaomapBrowseUrl(bridge: widget.bridge),
      javascriptChannels: [
        JavascriptChannel(
            name: 'BridgeID',
            onMessageReceived: (JavascriptMessage message) {
              // print(message.message);
              flutterWebViewPlugin.hide();
              _con.goDetail(message.message);
            }),
      ].toSet(),
      key: _con.scaffoldKey,
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.close, color: Colors.white),
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/DashboardPage')),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[600],
        // elevation: 0,
        centerTitle: true,
        title: Text(widget.bridge.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // flutterWebViewPlugin.reloadUrl(MapController.getKakaomapBrowseUrl(
              //   address: address,
              // ));
              // FocusScope.of(context).unfocus();
              flutterWebViewPlugin.hide();
              Navigator.of(context).pushNamed('/MapSearchPage');
            },
          ),
        ],
      ),
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Colors.white),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(1.0))),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      hasFloatingPlaceholder: true,
      labelStyle: Theme.of(context).textTheme.body1.merge(
            TextStyle(color: Colors.white),
          ),
    );
  }
}

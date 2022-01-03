import 'package:flutter/material.dart';
import 'package:sensor_viewer/adapter/grid_basic_adapter.dart';
import 'package:sensor_viewer/data/dummy.dart';
import 'package:sensor_viewer/widget/toolbar.dart';

class GridBasicRoute extends StatefulWidget {
  GridBasicRoute();

  @override
  GridBasicRouteState createState() => new GridBasicRouteState();
}

class GridBasicRouteState extends State<GridBasicRoute> {
  void onItemClick(int index, String obj) {}

  @override
  Widget build(BuildContext context) {
    List<String> items = Dummy.getNatureImages();
    items.addAll(Dummy.getNatureImages());
    items.addAll(Dummy.getNatureImages());
    items.addAll(Dummy.getNatureImages());

    return new Scaffold(
      appBar: CommonAppBar.getPrimarySettingAppbar(context, "Basic"),
      body: GridBasicAdapter(items, onItemClick).getView(),
    );
  }
}

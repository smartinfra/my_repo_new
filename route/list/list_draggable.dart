import 'package:flutter/material.dart';
import 'package:sensor_viewer/adapter/list_basic_adapter.dart';
import 'package:sensor_viewer/adapter/list_draggable_adapter.dart';
import 'package:sensor_viewer/data/dummy.dart';
import 'package:sensor_viewer/model/people.dart';
import 'package:sensor_viewer/widget/toolbar.dart';
import 'package:toast/toast.dart';

class ListDraggableRoute extends StatefulWidget {
  ListDraggableRoute();

  @override
  ListDraggableRouteState createState() => new ListDraggableRouteState();
}

class ListDraggableRouteState extends State<ListDraggableRoute> {
  BuildContext context;
  List<People> items;

  void onReorder() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    items = Dummy.getPeopleData();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return new Scaffold(
      appBar: CommonAppBar.getPrimaryAppbar(context, "Draggable"),
      body: ListDraggableAdapter(items, onReorder).getView(),
    );
  }
}

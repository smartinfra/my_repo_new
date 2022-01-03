import 'package:flutter/material.dart';
import 'package:sensor_viewer/adapter/list_basic_adapter.dart';
import 'package:sensor_viewer/adapter/list_swipe_adapter.dart';
import 'package:sensor_viewer/data/dummy.dart';
import 'package:sensor_viewer/model/people.dart';
import 'package:sensor_viewer/widget/toolbar.dart';
import 'package:toast/toast.dart';

class ListSwipeRoute extends StatefulWidget {
  ListSwipeRoute();

  @override
  ListSwipeRouteState createState() => new ListSwipeRouteState();
}

class ListSwipeRouteState extends State<ListSwipeRoute> {
  BuildContext context;
  List<People> items;

  void onItemSwipe(int index, People obj) {
    setState(() {
      items.removeAt(index);
    });
    Toast.show(obj.name + " dismissed", context, duration: Toast.LENGTH_SHORT);
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
      appBar: CommonAppBar.getPrimaryAppbar(context, "Swipe"),
      body: ListSwipeAdapter(items, onItemSwipe).getView(),
    );
  }
}

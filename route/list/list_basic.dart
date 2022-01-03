import 'package:flutter/material.dart';
import 'package:sensor_viewer/adapter/list_basic_adapter.dart';
import 'package:sensor_viewer/data/dummy.dart';
import 'package:sensor_viewer/model/people.dart';
import 'package:sensor_viewer/widget/toolbar.dart';
import 'package:toast/toast.dart';

class ListBasicRoute extends StatefulWidget {
  ListBasicRoute();

  @override
  ListBasicRouteState createState() => new ListBasicRouteState();
}

class ListBasicRouteState extends State<ListBasicRoute> {
  BuildContext context;
  void onItemClick(int index, People obj) {
    Toast.show(obj.name, context, duration: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    List<People> items = Dummy.getPeopleData();
    items.addAll(Dummy.getPeopleData());
    items.addAll(Dummy.getPeopleData());

    return new Scaffold(
      appBar: CommonAppBar.getPrimarySettingAppbar(context, "Basic"),
      body: ListBasicAdapter(items, onItemClick).getView(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sensor_viewer/adapter/list_basic_adapter.dart';
import 'package:sensor_viewer/adapter/list_expand_adapter.dart';
import 'package:sensor_viewer/data/dummy.dart';
import 'package:sensor_viewer/model/people.dart';
import 'package:sensor_viewer/widget/toolbar.dart';
import 'package:toast/toast.dart';

class ListExpandRoute extends StatefulWidget {
  ListExpandRoute();

  @override
  ListExpandRouteState createState() => new ListExpandRouteState();
}

class ListExpandRouteState extends State<ListExpandRoute> {
  BuildContext context;
  List<People> items;

  @override
  void initState() {
    super.initState();
    items = Dummy.getPeopleData();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return new Scaffold(
      appBar: CommonAppBar.getPrimaryAppbar(context, "Expand"),
      body: ListExpandAdapter(items).getView(),
    );
  }
}

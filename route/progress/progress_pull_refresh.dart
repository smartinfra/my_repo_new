import 'package:flutter/material.dart';
import 'package:sensor_viewer/adapter/list_sectioned_adapter.dart';
import 'package:sensor_viewer/data/dummy.dart';
import 'package:sensor_viewer/model/people.dart';
import 'package:sensor_viewer/widget/toolbar.dart';
import 'package:toast/toast.dart';

class ProgressPullRefreshRoute extends StatefulWidget {
  ProgressPullRefreshRoute();

  @override
  ProgressPullRefreshRouteState createState() =>
      new ProgressPullRefreshRouteState();
}

class ProgressPullRefreshRouteState extends State<ProgressPullRefreshRoute> {
  BuildContext context;
  ListSectionedAdapter adapter;
  void onItemClick(int index, People obj) {
    Toast.show(obj.name, context, duration: Toast.LENGTH_SHORT);
  }

  @override
  void initState() {
    super.initState();
    List<People> items = Dummy.getPeopleData();
    items.addAll(Dummy.getPeopleData());
    int sectCount = 0;
    int sectIdx = 0;
    List<String> months = Dummy.getStringsMonth();
    for (int i = 0; i < items.length / 6; i++) {
      items.insert(sectCount, new People.section(months[sectIdx], true));
      sectCount = sectCount + 5;
      sectIdx++;
    }

    adapter = ListSectionedAdapter(items, onItemClick);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return new Scaffold(
      appBar: CommonAppBar.getPrimarySettingAppbar(context, "Pull Refresh"),
      body: new RefreshIndicator(
        child: adapter.getView(),
        onRefresh: onPullRefresh,
      ),
    );
  }

  Future<void> onPullRefresh() async {
    People item = Dummy.getPeopleData()[0];
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      adapter.addItem(item);
    });
  }
}

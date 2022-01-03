import 'dart:developer';

/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../model/bridge_info.dart';
import '../model/list_item.dart';

/*
 * 링크 참고
 * https://google.github.io/charts/flutter/gallery 
 * https://google.github.io/charts/flutter/example/bar_charts/grouped
 * https://google.github.io/charts/flutter/example/behaviors/selection_user_managed.html (특정 element 선택 callback)
 * https://google.github.io/charts/flutter/example/behaviors/selection_callback_example.html (참고 : callback 관련)
 */
class ChartBarWidget extends StatefulWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final List<BridgeInfo> triggers;

  ChartBarWidget(this.seriesList, {this.animate, this.triggers});

  factory ChartBarWidget.withData(trigger, pga, pgd) {
    return ChartBarWidget(_createData(pga, pgd),
        // Disable animations for image tests.
        animate: false,
        triggers: trigger);
  }

  /// Create series list with multiple series
  static List<charts.Series<ListItem, String>> _createData(pga, pgd) {
    return [
      new charts.Series<ListItem, String>(
          id: '가속도', // 가속도
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ListItem item, _) => item.name,
          measureFn: (ListItem item, _) => double.parse(item.value),
          data: pga),
      new charts.Series<ListItem, String>(
          id: '변위', // 변위
          colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
          domainFn: (ListItem item, _) => item.name,
          measureFn: (ListItem item, _) => double.parse(item.value),
          data: pgd)
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }

  @override
  SelectionUserManagedState createState() {
    return new SelectionUserManagedState();
  }
}

class SelectionUserManagedState extends State<ChartBarWidget> {
  // final _myState = new charts.UserManagedState<String>();

  // String _time;
  // Map<String, num> _measures;

  // Listens to the underlying selection changes, and updates the information
  // relevant to building the primitive legend like information under the
  // chart.
  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    // String time;
    // final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      // time = selectedDatum.first.datum.name.toString();
      // selectedDatum.forEach((charts.SeriesDatum datumPair) {
      //   measures[datumPair.series.displayName] = datumPair.datum.value;
      // });
      String time = selectedDatum.first.datum.name;
      print(widget.triggers
          .where((element) => element.time == time)
          .elementAt(0)
          .pga);

      Navigator.of(context).pushNamed('/BridgeTriggerPage',
          arguments: widget.triggers
              .where((element) => element.time == time)
              .elementAt(0));
    }

    // Request a build.
    // setState(() {
    //   _time = time;
    //   _measures = measures;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: charts.BarChart(
              widget.seriesList,
              animate: widget.animate,
              // barGroupingType: charts.BarGroupingType.grouped,
              // behaviors: [new charts.PanAndZoomBehavior()],
              defaultRenderer: new charts.BarRendererConfig(
                  groupingType: charts.BarGroupingType.grouped),
              customSeriesRenderers: [
                new charts.LineRendererConfig(
                    // ID used to link series to this renderer.
                    customRendererId: 'customLine')
              ],
              selectionModels: [
                new charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    updatedListener: _onSelectionChanged)
              ],
              behaviors: [
                new charts.SeriesLegend(
                  // Positions for "start" and "end" will be left and right respectively
                  // for widgets with a build context that has directionality ltr.
                  // For rtl, "start" and "end" will be right and left respectively.
                  // Since this example has directionality of ltr, the legend is
                  // positioned on the right side of the chart.
                  position: charts.BehaviorPosition.top,
                  // By default, if the position of the chart is on the left or right of
                  // the chart, [horizontalFirst] is set to false. This means that the
                  // legend entries will grow as new rows first instead of a new column.
                  horizontalFirst: false,
                  // This defines the padding around each legend entry.
                  cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                  // Set show measures to true to display measures in series legend,
                  // when the datum is selected.
                  showMeasures: true,
                  // Optionally provide a measure formatter to format the measure value.
                  // If none is specified the value is formatted as a decimal.
                  measureFormatter: (num value) {
                    // return value == null ? '-' : '${value}k';
                    return value == null ? '-' : value.toString();
                  },
                ),
              ],
            ),
          ),
          // Divider(),
          // Container(
          //   child: FlatButton(
          //     child: Text(
          //       "상세보기",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     color: Colors.blueGrey[800],
          //     onPressed: () {
          //       // Navigator.of(context)
          //       //     .pushNamed('/BridgeTriggerPage', arguments: _bridge);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

/// Example of a simple line chart.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:sensor_viewer/model/list_item.dart';

class ChartLineWidget extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  ChartLineWidget(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory ChartLineWidget.withData(title, data) {
    return new ChartLineWidget(
      _createData(title, data),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: new charts.LineChart(seriesList, animate: animate, behaviors: [
          new charts.PanAndZoomBehavior(),
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
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ListItem, double>> _createData(title, data) {
    return [
      new charts.Series<ListItem, double>(
        id: title,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ListItem item, _) => double.parse(item.name),
        measureFn: (ListItem item, _) => double.parse(item.value),
        data: data,
      )
    ];
  }
}

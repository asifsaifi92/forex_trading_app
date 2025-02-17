import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../data/models/forexHistoryData.dart';

class ForexChart extends StatelessWidget {
  final List<ForexHistoricalData> data;

  const ForexChart(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ForexHistoricalData, DateTime>> series = [
      charts.Series(
        id: "Forex",
        data: data,
        domainFn: (ForexHistoricalData history, _) => history.date,
        measureFn: (ForexHistoricalData history, _) => history.price,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      defaultRenderer: charts.LineRendererConfig(),
      behaviors: [
        charts.PanAndZoomBehavior(),
        charts.ChartTitle('Price History'),
        charts.ChartTitle('Date', behaviorPosition: charts.BehaviorPosition.bottom),
        charts.ChartTitle('Price', behaviorPosition: charts.BehaviorPosition.start),
      ],
    );
  }
}

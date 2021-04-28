import 'dart:ui';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/chart_sample_data.dart';
import '../data.dart';

class CattleBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 300,
          width: 600,
          padding: EdgeInsets.only(top: 0, bottom: 25, left: 25, right: 25),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
          ),
          child: FutureBuilder(
            future: Future.delayed(Duration(seconds: 5)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    title: ChartTitle(
                        text: "Cattle Count",
                        textStyle: TextStyle(color: Colors.white)),
                    primaryXAxis: CategoryAxis(
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        numberFormat: NumberFormat.compact()),
                    series: _getDefaultBarSeries(),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    palette: [Colors.teal],
                  )
                : Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator())),
          ),
        ),
      ),
    );
  }

  /// Returns the list of chart series which need to render on the barchart.
  List<BarSeries<ChartSampleData, String>> _getDefaultBarSeries() {
    Map<String, num> _cattleData = getCattleData();
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
        x: 'Camel',
        y: _cattleData["camel"],
      ),
      ChartSampleData(
        x: 'Sheep',
        y: _cattleData["sheep"],
      ),
      ChartSampleData(
        x: 'Buffalo',
        y: _cattleData["buffalo"],
      ),
      ChartSampleData(
        x: 'Cow',
        y: _cattleData["cow"],
      ),
    ];
    return <BarSeries<ChartSampleData, String>>[
      BarSeries<ChartSampleData, String>(
          dataSource: chartData,
          xValueMapper: (ChartSampleData cattle, _) => cattle.x,
          yValueMapper: (ChartSampleData cattle, _) => cattle.y,
          name: 'Count'),
    ];
  }
}

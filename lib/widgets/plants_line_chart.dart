import 'dart:ui';
import 'package:agrivigilance/data.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class PlantsLineChart extends StatelessWidget {
  int periodMaxValue = 0;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 275,
          width: 900,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
          ),
          child: FutureBuilder(
            future: Future.delayed(Duration(seconds: 5)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    title: ChartTitle(
                        text: "Healthy Plants Trend",
                        textStyle: TextStyle(color: Colors.white)),
                    legend: Legend(
                        isVisible: true,
                        textStyle: TextStyle(color: Colors.white),
                        overflowMode: LegendItemOverflowMode.wrap),
                    primaryXAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 2,
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                        labelFormat: '{value}',
                        labelStyle: TextStyle(color: Colors.white),
                        axisLine: AxisLine(width: 0),
                        majorGridLines: MajorGridLines(width: 0),
                        majorTickLines:
                            MajorTickLines(color: Colors.transparent)),
                    series: _getDefaultLineSeries(),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    palette: [Colors.teal, Colors.red],
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    // final List<_ChartData> chartData = <_ChartData>[
    //   _ChartData(1, 70, 30),
    //   _ChartData(2, 76, 24),
    //   _ChartData(3, 76, 28),
    //   _ChartData(4, 82, 18),
    //   _ChartData(5, 83, 17),
    //   _ChartData(6, 87, 13),
    //   _ChartData(7, 91, 09)
    // ];
   
    var max =  getTotalPlantsCount();
    double count = -1;
    List<_ChartData> chartData = getAllHealthyPlantsNumber().map((e) {
      count++;
      return _ChartData(count, e, max - e);
    }).toList();
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y1,
          width: 2,
          name: 'Healthy',
          markerSettings: MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData,
          width: 2,
          name: 'Unhealthy',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: MarkerSettings(isVisible: true))
    ];
  }
}

class _ChartData {
  _ChartData(this.x, this.y1, this.y2);
  final double x;
  final double y1;
  final double y2;
}

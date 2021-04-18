import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/chart_sample_data.dart';
import '../data.dart';

class PlantPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 275,
          width: 275,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
          ),
          child: FutureBuilder(
            future: Future.delayed(Duration(seconds: 3)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? SfCircularChart(
                    title: ChartTitle(
                        text: "Plant Health",
                        textStyle: TextStyle(color: Colors.white)),
                    series: _getDefaultDoughnutSeries(),
                    palette: [
                      Colors.teal,
                      Colors.red,
                    ],
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  /// Returns the doughnut series which need to be render.
  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    var healthy = double.parse(getHealthyPlantPercent().toStringAsFixed(2));
    // var healthy = 63.33;
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'Healthy', y: healthy, text: '$healthy%'),
      ChartSampleData(
          x: 'Unhealthy', y: 100 - healthy, text: '${100 - healthy}%'),
    ];
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '10%',
          dataSource: chartData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: DataLabelSettings(isVisible: true))
    ];
  }
}

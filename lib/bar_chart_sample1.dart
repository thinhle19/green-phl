import 'package:bosch/provider/traffic_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class _BarChart extends StatelessWidget {
  final DailyData dailyData;

  _BarChart(this.dailyData);
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        alignment: BarChartAlignment.spaceAround,
        maxY: dailyData.maxValue + 2000,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff7589a2),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          margin: 20,
          getTitles: (double value) {
            var tmpCount = 0;
            switch (value.toInt()) {
              case 0:
                return dailyData.listData[tmpCount].keys.elementAt(0);
              case 1:
                return dailyData.listData[tmpCount + 1].keys.elementAt(0);
              case 2:
                return dailyData.listData[tmpCount + 2].keys.elementAt(0);
              case 3:
                return dailyData.listData[tmpCount + 3].keys.elementAt(0);
              case 4:
                return dailyData.listData[tmpCount + 4].keys.elementAt(0);
              case 5:
                return dailyData.listData[tmpCount + 5].keys.elementAt(0);
              case 6:
                return dailyData.listData[tmpCount + 6].keys.elementAt(0);
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: true),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  int count = 0;

  List<BarChartGroupData> get barGroups => dailyData.listData
      .map(
        (e) => BarChartGroupData(
          x: count++,
          barRods: [
            BarChartRodData(
                y: e.values.elementAt(0),
                colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
      )
      .toList();

  /* List<BarChartGroupData> get barGroupss => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                y: 8, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                backDrawRodData: BackgroundBarChartRodData(
                  y: 20,
                  colors: [Colors.yellow, Colors.red],
                ),
                y: 10,
                colors: [Colors.lightBlueAccent, Colors.greenAccent]),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                y: 14, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 50, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 13, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 10, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        ),
      ]; */
}

class BarChartSample1 extends StatefulWidget {
  final data;

  BarChartSample1(this.data);

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xff2c4260),
        child: Container(
          height: double.infinity,
          child: _BarChart(widget.data),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        ),
      ),
    );
  }
}

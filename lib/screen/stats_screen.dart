import 'dart:async';

import 'package:bosch/bar_chart_sample1.dart';
import 'package:bosch/fetch_and_show_test.dart';
import 'package:bosch/provider/traffic_data.dart';
import 'package:bosch/widget/circle_info_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  static const routeName = "/stats";

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  var _isInit = true;
  var _isLoading = false;
  String currentTime = "";

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      //load init
      Provider.of<TrafficData>(context, listen: false).getLiveData().then(
            (_) => {
              setState(() {
                _isLoading = false;
              })
            },
          );

      //create a periodTimer
      Timer.periodic(const Duration(seconds: 1), (timer) {
        DateTime now = DateTime.now();
        if (now.second == 2) {
          setState(() {
            _isLoading = true;
            Provider.of<TrafficData>(context, listen: false)
                .getLiveData()
                .then((value) => {
                      setState(() {
                        _isLoading = false;
                      })
                    });
          });
        }
        currentTime = now.toString();

        setState(() {
          currentTime = currentTime.substring(0, currentTime.length - 7);
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final liveTfData = Provider.of<TrafficData>(context);
    final dailyChartData = liveTfData.dailyData;

    return Scaffold(
        appBar: AppBar(
          title: const Text("GreenPHL"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text("Hourly"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Daily"),
                  ),
                ],
              ),
            ),
            BarChartSample1(dailyChartData),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text("Current Time: $currentTime"),
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleInfoWidget(
                          borderColor:
                              (liveTfData.warningState == WarningState.normal)
                                  ? const Color.fromRGBO(127, 192, 89, 1)
                                  : const Color.fromRGBO(245, 66, 108, 1),
                          // data: liveTfData.currentTraffic.toString(),
                          child: _isLoading
                              ? const LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  colors: [Colors.cyan],
                                  strokeWidth: 20,
                                )
                              : Text(
                                  "${liveTfData.currentTraffic.toString()} people"),
                          suffix: "people",
                        ),
                        CircleInfoWidget(
                          borderColor:
                              (liveTfData.warningState == WarningState.normal)
                                  ? const Color.fromRGBO(127, 192, 89, 1)
                                  : const Color.fromRGBO(245, 66, 108, 1),
                          child: const Text("Hello"),
                          suffix: "ppm",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Flexible(
                    flex: 2,
                    child: Text((liveTfData.warningState == WarningState.normal)
                        ? "Everything is ok"
                        : "Alert!!!"),
                  ),
                  const SizedBox(height: 30),
                  Flexible(
                    flex: 2,
                    child: TextButton(
                      child: const Text(
                        "View all data",
                      ),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

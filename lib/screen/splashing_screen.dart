import 'package:bosch/provider/traffic_data.dart';
import 'package:bosch/screen/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class SplashingScreen extends StatefulWidget {
  static const routeName = "splashing";

  @override
  State<SplashingScreen> createState() => _SplashingScreenState();
}

class _SplashingScreenState extends State<SplashingScreen> {
  @override
  Widget build(BuildContext context) {
    final liveTfData = Provider.of<TrafficData>(context);
    liveTfData.getDailyData();
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromRGBO(223, 250, 251, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/logo.png"),
            ),
            Container(
                height: 50,
                width: 150,
                child:
                    const LoadingIndicator(indicatorType: Indicator.lineScale)),
          ],
        ),
      ),
    );
  }
}

import 'package:bosch/provider/traffic_data.dart';
import 'package:bosch/screen/splashing_screen.dart';
import 'package:bosch/screen/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => TrafficData(),
      child: Consumer<TrafficData>(
        builder: (ctx, tfData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GREENPHL',
          theme: ThemeData(
            primarySwatch: Colors.cyan,
            fontFamily: "Andada",
          ),
          home: tfData.doneLoading ? StatsScreen() : SplashingScreen(),
          routes: {
            StatsScreen.routeName: (ctx) => StatsScreen(),
            SplashingScreen.routeName: (ctx) => SplashingScreen(),
          },
        ),
      ),
    );
  }
}

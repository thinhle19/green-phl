import 'package:bosch/fetch_and_show_test.dart';
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
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
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

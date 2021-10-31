import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_phl/provider/data.dart';
import 'package:green_phl/screens/manual_screen.dart';
import 'package:green_phl/screens/main_screen.dart';
import 'package:green_phl/screens/splashing_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Data(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          fontFamily: "Poppins",
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 27,
              color: Colors.black,
            ),
            bodyText1: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            bodyText2: TextStyle(
              fontSize: 18,
              color: Colors.cyan,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashingScreen(),
        routes: {
          MainScreen.routeName: (context) => const MainScreen(),
          ManualScreen.routeName: (context) => const ManualScreen(),
        },
      ),
    );
  }
}

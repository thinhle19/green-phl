import 'package:flutter/material.dart';
import 'package:green_phl/screens/manual_screen.dart';
import 'package:green_phl/screens/main_screen.dart';
import 'package:green_phl/widget/background.dart';

class SplashingScreen extends StatelessWidget {
  const SplashingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(ManualScreen.routeName);
      },
      child: Stack(
        children: [
          const Background(),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 240,
              width: 240,
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo-white.jpg"),
              ),
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5)],
                borderRadius: BorderRadius.all(
                  Radius.circular(200),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

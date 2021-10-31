import 'dart:async';

import 'package:flutter/material.dart';
import 'package:green_phl/widget/background.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        fit: StackFit.loose,
        children: [
          const Background(),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            width: size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                GreetingBar(),
                SizedBox(
                  height: 40,
                ),
                SizedBox(height: 260, width: 260, child: MainCircle()),
                SizedBox(
                  height: 60,
                ),
                InformationWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainCircle extends StatelessWidget {
  const MainCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            child: const CircularSpin(),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(150)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2, 2),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 248,
                alignment: Alignment.center,
                width: 248,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(500),
                  ),
                  color: Colors.lightGreenAccent,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey,
                  //     offset: Offset(2, 2),
                  //     blurRadius: 5,
                  //   ),
                  // ],
                ),
                child: const Text(
                  "700 ppm CO2",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularSpin extends StatelessWidget {
  const CircularSpin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 260,
      curve: Curves.linear,
      lineWidth: 7,
      percent: 1,
      linearGradient: LinearGradient(colors: [
        Colors.red[400]!,
        Colors.orange[400]!,
        Colors.yellow[400]!,
        Colors.lightGreenAccent,
      ]),
    );
  }
}

class InformationWidget extends StatelessWidget {
  const InformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 40,
            bottom: 40,
            child: Container(
              height: 120,
              width: 300,
              color: Colors.white.withOpacity(0.4),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Cur CO2: 2 ppm",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "Avg CO2: 32 ppm",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "Over CO2: 500 ppm",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            child: PeopleCircle(),
            top: 20,
            bottom: 20,
            right: 40,
          ),
        ],
      ),
    );
  }
}

class PeopleCircle extends StatelessWidget {
  const PeopleCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      alignment: Alignment.center,
      width: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.cyan[100]!,
            Colors.purple[100]!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(500),
        ),
        color: Colors.lightGreenAccent,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: const Text(
        "5 People",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

class GreetingBar extends StatelessWidget {
  const GreetingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Container(
        height: 110,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          //TODO: Use more custom gradient
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.cyan.withOpacity(0.3),
              Colors.white,
            ],
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        width: double.infinity,
        child: const ListTile(
          title: Text("Welcome back"),
          subtitle: Text(
            "Coby Lee",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          //TODO: add elevation
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.jpg"),
            radius: 30,
          ),
        ),
      ),
    );
  }
}

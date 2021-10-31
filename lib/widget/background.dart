import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: ColorFiltered(
            colorFilter:
                const ColorFilter.mode(Colors.cyan, BlendMode.colorDodge),
            child: SizedBox(
              height: double.infinity,
              child: Image.asset(
                "assets/images/bg.jpg",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.cyan.withOpacity(0.4),
                Colors.white.withOpacity(0.4),
              ],
            ),
          ),
        )
      ],
    );
  }
}

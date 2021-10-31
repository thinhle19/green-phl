import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final bottomFieldRatio;
  final Widget contentChild;
  final Widget titleChild;
  final bool isHavingNavBar;

  const ScreenLayout({
    Key? key,
    this.bottomFieldRatio = 0.75,
    required this.titleChild,
    required this.contentChild,
    this.isHavingNavBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      color: Theme.of(context).colorScheme.primary,
      child: Stack(
        children: [
          Positioned(
            height: size.height * (1 - bottomFieldRatio) -
                (isHavingNavBar ? 70 : 0),
            width: size.width,
            //70 is size of bottom nav bar
            child: Align(alignment: Alignment.center, child: titleChild),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * bottomFieldRatio,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    spreadRadius: 0.3,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: contentChild,
            ),
          )
        ],
      ),
    );
  }
}

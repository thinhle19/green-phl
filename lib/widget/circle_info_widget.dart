import 'package:bosch/provider/traffic_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CircleInfoWidget extends StatelessWidget {
  Widget child;
  String suffix;
  Color borderColor;
  double width = 150;
  CircleInfoWidget({
    required this.child,
    required this.suffix,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(80))),
      child: Center(
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:green_phl/widget/list_element.dart';
import 'package:green_phl/widget/screen_layout.dart';

class NotiScreen extends StatelessWidget {
  const NotiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      titleChild: Text(
        "Notifications",
        style: Theme.of(context).textTheme.headline1,
      ),
      contentChild: Image.asset("assets/images/no-noti.jpg"),
    );
  }
}

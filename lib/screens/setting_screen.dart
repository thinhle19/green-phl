import 'package:flutter/material.dart';
import 'package:green_phl/widget/list_element.dart';
import 'package:green_phl/widget/screen_layout.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      titleChild: Text(
        "Settings",
        style: Theme.of(context).textTheme.headline1,
      ),
      contentChild: ListView(
        children: const [
          ListElement(title: "Change Password", icon: Icons.password_outlined),
          ListElement(title: "Language", icon: Icons.language_outlined),
        ],
      ),
    );
  }
}

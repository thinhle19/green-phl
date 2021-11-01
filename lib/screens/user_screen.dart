import 'package:flutter/material.dart';
import 'package:green_phl/widget/list_element.dart';
import 'package:green_phl/widget/screen_layout.dart';
import 'package:green_phl/widget/title_with_pic.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      bottomFieldRatio: 0.65,
      titleChild: const TitleWithPic(
        assetPath: 'assets/images/avatar.png',
        title: "Coby Lee",
      ),
      contentChild: ListView(
        children: const [
          ListElement(
              title: "Personal Information", icon: Icons.person_outline_sharp),
          ListElement(title: "Environment", icon: Icons.air),
          ListElement(title: "History", icon: Icons.history),
          ListElement(
              title: "Connections",
              icon: Icons.connect_without_contact_outlined),
          ListElement(title: "About", icon: Icons.info_outline_rounded),
          ListElement(title: "Log Out", icon: Icons.logout_outlined),
        ],
      ),
    );
  }
}

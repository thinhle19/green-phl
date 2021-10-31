import 'package:flutter/material.dart';
import 'package:green_phl/screens/home_screen.dart';
import 'package:green_phl/screens/noti_screen.dart';
import 'package:green_phl/screens/setting_screen.dart';
import 'package:green_phl/screens/user_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/main";
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  navigateTopage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          HomePage(),
          NotiScreen(),
          UserScreen(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.cyan[400],
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 1.0),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _bottomAppbarIcon(
                  index: 0, icon: Icons.home_outlined, title: "Home"),
              _bottomAppbarIcon(
                  index: 1,
                  icon: Icons.notifications_active_outlined,
                  title: "Notifications"),
              _bottomAppbarIcon(
                  index: 2,
                  icon: Icons.supervised_user_circle_outlined,
                  title: "User"),
              _bottomAppbarIcon(
                  index: 3, icon: Icons.settings, title: "Settings"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAppbarIcon(
      {required int index, required IconData icon, required title}) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            navigateTopage(index);
          },
          icon: Icon(
            icon,
            color: _selectedIndex == index ? Colors.black : Colors.white,
          ),
          iconSize: 32,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index ? Colors.black : Colors.white),
        )
      ],
    );
  }
}

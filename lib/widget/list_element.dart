import 'package:flutter/material.dart';

class ListElement extends StatelessWidget {
  final String title;
  final IconData icon;
  const ListElement({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      enableFeedback: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                icon,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                title,
                style: TextStyle(fontSize: 17),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black45,
              indent: 18,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TitleWithPic extends StatelessWidget {
  final String title;
  final assetPath;
  const TitleWithPic({
    Key? key,
    required this.title,
    this.assetPath = "assets/images/logo-white.jpg",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 0), blurRadius: 7),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(70),
            ),
          ),
          child: CircleAvatar(
            backgroundImage: AssetImage(assetPath),
            radius: 60,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 27, color: Colors.black),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';

enum EnvironmentType {
  home,
  office,
  school,
  studio,
  tranport,
  other,
}

class Data with ChangeNotifier {
  EnvironmentType environmentType;
  double length;
  double width;
  double height;
  int memberNum;
  Map<String, bool> additionDevices;
  bool isInit = false;

  Data({
    this.length = 1,
    this.width = 1,
    this.height = 1,
    this.memberNum = 1,
    this.environmentType = EnvironmentType.home,
    this.additionDevices = const {},
  });

  List<String> get envTypes {
    return [
      'Home',
      'Office',
      'School',
      'Studio',
      'Transport',
      'Other',
    ];
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  double curCO2;
  bool isNotSafe = false;
  bool isInit = false;

  Data({
    this.length = 1,
    this.width = 1,
    this.height = 1,
    this.memberNum = 10,
    this.environmentType = EnvironmentType.home,
    this.curCO2 = 400,
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

  void changeState() {
    isNotSafe = !isNotSafe;
    notifyListeners();
  }

  void changeEnvType(String typeString) {
    switch (typeString) {
      case 'Home':
        environmentType = EnvironmentType.home;
        break;
      case 'Office':
        environmentType = EnvironmentType.office;
        break;
      case 'School':
        environmentType = EnvironmentType.school;
        break;
      case 'Studio':
        environmentType = EnvironmentType.studio;
        break;
      case 'Transport':
        environmentType = EnvironmentType.tranport;
        break;
      case 'Other':
        environmentType = EnvironmentType.other;
        break;
    }
  }

  void changePeopleNum(String peopleNum) {
    memberNum = int.parse(peopleNum);
    notifyListeners();
  }

  Future<void> getInitData() async {
    var url = Uri.parse(
        'https://api.thingspeak.com/channels/1554577/fields/1.json?results=1');
    final response = await http.get(url);
    var data = jsonDecode(response.body)['feeds'][0]['field1'];
    print(data);
    curCO2 = double.parse(data);
    if (curCO2 > 702) {
      isNotSafe = true;
    } else {
      isNotSafe = false;
    }
    isInit = true;
    notifyListeners();
  }

  Future<void> getLiveData() async {
    try {
      var url = Uri.parse(
          'https://api.thingspeak.com/channels/1554577/fields/1.json?results=1');
      final response = await http.get(url);
      var data = jsonDecode(response.body)['feeds'][0]['field1'];
      curCO2 = double.parse(data);
      //702 for 10
      if (curCO2 > 702 && memberNum <= 12) {
        isNotSafe = true;
        //1045 for 35
      } else if (memberNum > 30 && curCO2 > 1045) {
        isNotSafe = true;
      } else {
        isNotSafe = false;
      }
      isInit = true;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}

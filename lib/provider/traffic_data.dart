import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DailyData {
  int count = 7;
  Map<String, dynamic> mapData = {};
  List<Map<String, dynamic>> listData = [];

  void validateData() {
    mapData = mapData.map((key, value) {
      var date = DateFormat("yyyy-MM-dd").parse(key.toString());
      key = "${date.day}/${date.month}";
      return MapEntry(key, value);
    });
    mapData.forEach((key, value) {
      listData.add({key: value.toDouble()});
    });
  }

  get maxValue {
    int max = -1;
    mapData.forEach((key, value) {
      if (value > max) {
        max = value;
      }
    });
    return (max - (max % 1000) + 1000).toDouble();
  }
}

enum WarningState {
  normal,
  warning,
}

class TrafficData with ChangeNotifier {
  int passingPeople = 0;
  final _cameraIP = "127.0.0.2";
  String? _token =
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJwcms3ODgzLXd5YWloaS1hcGkiLCJpYXQiOjE2MzQ5MjU4NTUsImV4cCI6MTYzNTUzMDY1NX0.fzzhgWHBKwfDfqoy6XxqHx_SdBVHJUfqsoi5L-IaHXE";
  int currentTraffic = 0;
  final dailyData = DailyData();
  bool doneLoading = false;

  WarningState get warningState {
    return (currentTraffic > 0) ? WarningState.warning : WarningState.normal;
  }

  String _getCurrentDateString() {
    DateTime currentTime = DateTime.now();
    // currentTime.subtract(
    //   const Duration(minutes: 1),
    // );
    String timeString = currentTime.toString();
    timeString = timeString.substring(0, timeString.length - 7);
    timeString =
        timeString.replaceRange(timeString.length - 2, timeString.length, "00");
    return timeString;
  }

  String _getFormattedDayString(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }

  Future<void> getDailyData() async {
    var endDate = DateTime.now().subtract(Duration(days: 1));
    var startDate = endDate.subtract(Duration(days: 7));
    var url = Uri.parse(
        "https://traffic.bosch-hackathon.com.vn/api/traffic/daily?cameraIp=${_cameraIP}&from=$startDate&to=$endDate");

    try {
      final response = await http.get(
        url,
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $_token",
        },
      );
      dailyData.mapData =
          (jsonDecode(response.body)["values"] as Map<String, dynamic>);
      dailyData.validateData();
      doneLoading = true;
      print(dailyData.mapData);
      print(dailyData.listData);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getLiveData() async {
    var url = Uri.parse(
        "https://traffic.bosch-hackathon.com.vn/api/traffic/live?cameraIp=${_cameraIP}");
    try {
      final response = await http.get(
        url,
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $_token",
        },
      );
      final listData = json.decode(response.body)["last30Minutes"];

      currentTraffic = listData[_getCurrentDateString()];
      notifyListeners();
      // print(listData);
      // print(_getCurrentDateString());
      // print(listData[_getCurrentDateString()]);
      // liveData = listData[listData.length - 1];
      // print(liveData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> authenticate() async {
    var url =
        Uri.parse("https://traffic.bosch-hackathon.com.vn/api/authenticate");

    try {
      final response = await http.post(url,
          headers: {
            "accept": "application/json",
            "Content-Type": "application/json"
          },
          body: json.encode(
            {
              "username": "prk7883-wyaihi-api",
              "password": "Me-7mnSDtiaUAzXp",
            },
          ));
      _token = json.decode(response.body)["token"];
      print(_token);
    } catch (error) {
      rethrow;
    }
  }
}

import 'package:bosch/provider/traffic_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FetchAndShowTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tfData = Provider.of<TrafficData>(context);
    // tfData.authenticate().then((value) => tfData.getData());
    tfData.getLiveData();
    return Center(
      child: Text("Test"),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class DeviceView extends StatefulWidget {
  @override
  _DeviceViewState createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '登录设备管理',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}

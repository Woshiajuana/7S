
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '设置',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new Container()
        ],
      ),
    );
  }
}

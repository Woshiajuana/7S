
import 'package:flutter/material.dart';

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '关于我们',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Text(
          '一个 Flutter 搭起来的 APP...',
          style: new TextStyle(
            color: Color(0xff666666),
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class MineCenterView extends StatefulWidget {
  @override
  _MineCenterViewState createState() => _MineCenterViewState();
}

class _MineCenterViewState extends State<MineCenterView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '个人中心',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

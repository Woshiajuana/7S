
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class FollowerListView extends StatefulWidget {
  @override
  _FollowerListViewState createState() => _FollowerListViewState();
}

class _FollowerListViewState extends State<FollowerListView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '关注',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

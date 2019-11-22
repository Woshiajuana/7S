
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class CollectListView extends StatefulWidget {
  @override
  _CollectListViewState createState() => _CollectListViewState();
}

class _CollectListViewState extends State<CollectListView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '收藏',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

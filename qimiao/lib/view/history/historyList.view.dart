
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class HistoryListView extends StatefulWidget {
  @override
  _HistoryListViewState createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '浏览历史',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

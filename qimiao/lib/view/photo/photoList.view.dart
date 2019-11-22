
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class PhotoListView extends StatefulWidget {
  @override
  _PhotoListViewState createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '照片',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

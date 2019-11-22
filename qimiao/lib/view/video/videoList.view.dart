
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class VideoListView extends StatefulWidget {
  @override
  _VideoListViewState createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '视频',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

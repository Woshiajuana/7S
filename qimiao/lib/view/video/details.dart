
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';

class VideoDetailsView extends StatefulWidget {
  @override
  _VideoDetailsViewState createState() => _VideoDetailsViewState();
}

class _VideoDetailsViewState extends State<VideoDetailsView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.mainColor,
      body: new NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              
            ),
          ];
        },
        body: new ListView(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}

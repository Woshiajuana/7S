
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';

class VideoDetailsView extends StatefulWidget {
  @override
  _VideoDetailsViewState createState() => _VideoDetailsViewState();
}

class _VideoDetailsViewState extends State<VideoDetailsView> {

  // 导航条
  Widget _widgetAppBarSection ({
    double shrinkOffset,
    int alpha,
  }) {
    return new Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: new Container(
        color: Color.fromARGB(alpha, 236, 100, 47),
        child: new SafeArea(
          bottom: false,
          child: new Container(
            height: 56.0,
            child: new Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    color: shrinkOffset <= 50 ? Colors.white : Color.fromARGB(alpha, 255, 255, 255),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                new SizedBox(width: 24.0),
                new Text(
                  '我是阿倦啊',
                  style: new TextStyle(
                    color: shrinkOffset <= 50 ? Colors.transparent : Color.fromARGB(alpha, 255, 255, 255),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.mainColor,
      body: new WowScrollerInfo(
        builder: (BuildContext context, double shrinkOffset, int alpha) {
          return new Stack(
            children: <Widget>[
              new ListView(
                children: <Widget>[

                ],
              ),
              _widgetAppBarSection(shrinkOffset: shrinkOffset, alpha: alpha),
            ],
          );
        },
      ),
    );
  }

}

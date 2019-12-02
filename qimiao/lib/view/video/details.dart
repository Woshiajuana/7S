
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
      body: new NotificationListener<ScrollNotification>(
        onNotification: _handleScroll,
        child: new Stack(
          children: <Widget>[
            new ListView(
              children: <Widget>[
                new Container(color: Colors.blue, height: 200.0),
                new SizedBox(height: 10.0),
                new Container(color: Colors.red, height: 200.0),
                new SizedBox(height: 10.0),
                new Container(color: Colors.red, height: 200.0),
                new SizedBox(height: 10.0),
                new Container(color: Colors.red, height: 200.0),
                new SizedBox(height: 10.0),
                new Container(color: Colors.red, height: 200.0),
                new SizedBox(height: 10.0),
                new Container(color: Colors.red, height: 200.0),
                new SizedBox(height: 10.0),
              ],
            )
          ],
        ),
      ),
    );
  }

  int _alpha = 255;

  // 滚动监听回调
  bool _handleScroll (ScrollNotification scroll) {
    // 当前滑动距离
    double currentExtent = scroll.metrics.pixels;
    final int alpha = (currentExtent / 200 * 255).clamp(0, 255).toInt();

    print('alpha=> $alpha');
    // 返回false，继续向上传递,返回true则不再向上传递
    return false;
  }

}

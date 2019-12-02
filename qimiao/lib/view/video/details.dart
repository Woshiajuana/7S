
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:video_player/video_player.dart';

class VideoDetailsView extends StatefulWidget {
  @override
  _VideoDetailsViewState createState() => _VideoDetailsViewState();
}

class _VideoDetailsViewState extends State<VideoDetailsView> {

  VideoPlayerController _controller;
  bool _isPlaying = false;
  String url = 'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(this.url)
    // 播放状态
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() { _isPlaying = isPlaying; });
        }
      })
    // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // 播放器
  Widget _widgetVideoPlaySection () {
    return new Center(
      child: _controller.value.initialized
      // 加载成功
          ? new AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ) : new Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      floatingActionButton: new FloatingActionButton(
        onPressed: _controller.value.isPlaying
            ? _controller.pause
            : _controller.play,
        child: new Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      body: new WowScrollerInfo(
        maxExtent: 300.0,
        builder: (BuildContext context, double shrinkOffset, int alpha) {
          return new Stack(
            children: <Widget>[
              new ListView(
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  _widgetVideoPlaySection(),
                  new Container(color: Colors.blue, height: 200),
                  new SizedBox(height: 100.0),
                  new Container(color: Colors.blue, height: 200),
                  new SizedBox(height: 100.0),
                  new Container(color: Colors.blue, height: 200),
                  new SizedBox(height: 100.0),
                  new Container(color: Colors.blue, height: 200),
                  new SizedBox(height: 100.0),
                ],
              ),
              _widgetAppBarSection(shrinkOffset: shrinkOffset, alpha: alpha),
            ],
          );
        },
      ),
    );
  }

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


}


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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new WowScrollerInfo(
        maxExtent: 100.0,
        builder: (BuildContext context, double shrinkOffset, int alpha) {
          return new Stack(
            children: <Widget>[
              new ListView(
                padding: const EdgeInsets.all(0),
                children: <Widget>[
                  // 播放器
                  _widgetVideoPlaySection(shrinkOffset: shrinkOffset),
                  // 用户
                  _widgetUserSection(),
                  // 标题
                  _widgetInfoSection(),
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

  // 播放器
  Widget _widgetVideoPlaySection ({
    double shrinkOffset,
  }) {
    if (shrinkOffset > 50) {
      _controller.pause();
    }
    // loading
    Widget _widgetLoadingItem () {
      return new Container(
        child: new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            new Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(Application.util.getImgPath('guide1.png'), fit: BoxFit.fill,)
            ),
            new Container(
              decoration: new BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.3),
              ),
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 20.0,
                  height: 20.0,
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: new CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
                new Text(
                  '加载中...',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // 播放器
    Widget _widgetVideoItem () {
      return new Container(
        width: double.infinity,
        child: new Stack(
          children: <Widget>[
            new AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            new Container(
              width: double.infinity,
              height: double.infinity,
              child: new FlatButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: _controller.value.isPlaying ? new Container() : new Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            )
          ],
        ),
      );
    }

    bool _initialized = _controller.value.initialized;

    return new Container(
      height: 200.0,
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _initialized ? _widgetVideoItem() : _widgetLoadingItem(),
        ],
      ),
    );
  }

  // 用户
  Widget _widgetUserSection () {
    return new Container(
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 16.0, right: 16.0),
              child: new FlatButton(
                padding: const EdgeInsets.all(0),
                onPressed: () => {},
                child: new Row(
                  children: <Widget>[
                    new Container(
                      width: 36.0,
                      height: 36.0,
                      child: new ClipRRect(
                        borderRadius: BorderRadius.circular(36.0),
                        child: new Image.asset(
                          Application.util.getImgPath('guide1.png'),
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    new SizedBox(width: 16.0),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          '我是阿倦啊',
                          style: new TextStyle(
                            color: Color(0xff333333),
//                    fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          new Container(
            width: 50.0,
            height: 24.0,
            decoration: new BoxDecoration(
              color: Application.config.style.mainColor,
              borderRadius: new BorderRadius.circular(4.0),
            ),
            child: new FlatButton(
              onPressed: () => {},
              padding: const EdgeInsets.all(0),
              child: new Text(
                '关注',
                style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 标题
  Widget _widgetInfoSection () {
    return new Container();
  }

}

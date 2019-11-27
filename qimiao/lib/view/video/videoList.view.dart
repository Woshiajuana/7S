
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';

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
      body: new ListView(
        children: <Widget>[
          _widgetCellItem(),
          _widgetCellItem(),
          _widgetCellItem(),
          _widgetCellItem(),
          _widgetCellItem(),
          _widgetCellItem(),
          _widgetCellItem(),
        ],
      ),
    );
  }

  // 视频
  Widget _widgetCellItem () {
    return new Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      height: 180.0,
      color: Colors.red,
      child: new Stack(
        children: <Widget>[
          new Image.asset(
            Application.util.getImgPath('splash_bg.png'),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          new Container(
            color: Color.fromRGBO(0, 0, 0, 0.3),
          ),
          new Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: new Container(
              height: 100.0,
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                ),
              ),
            ),
          ),
          new Container(
            alignment: Alignment.center,
            child: new FlatButton(
              child: new Icon(Icons.play_circle_filled, size: 60.0, color: Colors.white),
              onPressed: () => {},
            ),
          ),
          new Container(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      '今天的雪下得大',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    new Text(
                      '2019-10-10',
                      style: new TextStyle(
                        color: Color(0xffdddddd),
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                new SizedBox(height: 5.0),
                new Row(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.live_tv, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    new SizedBox(width: 16.0),
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.thumb_up, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    new SizedBox(width: 16.0),
                    new Row(
                      children: <Widget>[
                        new Icon(Icons.star_border, size: 14.0, color: Color(0xffdddddd)),
                        new SizedBox(width: 2.0),
                        new Text(
                          '100',
                          style: new TextStyle(
                            color: Color(0xffdddddd),
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    new Expanded(child: new Container(), flex: 1),
                    new Container(
                      height: 20.0,
                      width: 20.0,
                      child: new FlatButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => _handleOperate(),
                        child: new Icon(Icons.more_vert, size: 18.0, color: Color(0xffdddddd))
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 操作
  void _handleOperate () {
    showDialog(
      context: context,
      barrierDismissible: true,//是否点击空白区域关闭对话框,默认为true，可以关闭
      builder: (BuildContext context) {
        return new ActionSheetDialog(
          arrOptions: [
            {
              'text': '删除该视频',
              'onPressed': () {
                print('相册1');
              },
            },
            {
              'text': '分享到世界',
              'onPressed': () => print('拍照'),
            },
            {
              'text': '收回分享',
              'onPressed': () => print('拍照'),
            },
          ],
        );
      },
    );
  }

}

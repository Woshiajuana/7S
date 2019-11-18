
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class MineView extends StatefulWidget {
  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        actions: <Widget>[
          new Container(
            width: 60,
            child: new FlatButton(
              onPressed: () => {},
              child: new Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: new ListView(
        children: <Widget>[
          _widgetHeaderSection(),
          _widgetFollowSection(),
          _widgetMenuSection(),
        ],
      ),
    );
  }

  // 头部
  Widget _widgetHeaderSection () {
    return new Container(
      color: Application.config.style.mainColor,
      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: new Column(
        children: <Widget>[
          // 头像
          new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white, width: 2.0), // 边色与边宽度
              color: Color(0xFF9E9E9E), // 底色
              borderRadius: new BorderRadius.circular((41)), // 圆角度
//            borderRadius: new BorderRadius.vertical(top: Radius.elliptical(20, 50))
            ),
            child: new ClipOval(
              child: new FadeInImage.assetNetwork(
                width: 80.0,
                height: 80.0,
                placeholder: Application.config.style.srcGoodsNull,
                image: 'http://ossmk2.jfpays.com/www_make_v1/app/static/images/defaultFace013x.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          new SizedBox(height: 5.0),
          // 昵称
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  '我是阿倦啊',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 粉丝 or 关注
  Widget _widgetFollowSection () {
    return new Container(
      color: Application.config.style.mainColor,
      height: 70.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new FlatButton(
              onPressed: () => {},
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    '1000',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  new SizedBox(height: 3.0),
                  new Text(
                    '关注',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ],
              )
            ),
          ),
          new Expanded(
            flex: 1,
            child: new FlatButton(
              onPressed: () => {},
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    '1000',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  new SizedBox(height: 3.0),
                  new Text(
                    '粉丝',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                    ),
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }

  // 菜单
  Widget _widgetMenuSection () {
    List _arrMenu = [
      {
        'text': '视频',
        'icon': Icons.videocam,
        'color': Color(0xff43bdbe),
      },
      {
        'text': '相册',
        'icon': Icons.photo_camera,
        'color': Color(0xffd76c93),
      },
      {
        'text': '收藏',
        'icon': Icons.headset,
        'color': Color(0xff7c4a7d),
      },
      {
        'text': '设置',
        'icon': Icons.settings,
        'color': Color(0xffeacb5f),
      },
    ];
    return new Column(
      children: _arrMenu.map((item) {
        return _widgetMenuItem(
          onPressed: () => {},
          text: item['text'],
          icon: item['icon'],
          color: item['color'],
        );
      }).toList(),
    );
  }

  Widget _widgetMenuItem ({
    dynamic onPressed,
    Color color,
    String text = '',
    IconData icon,
  }) {
    return new Container(
      height: 77.0,
      color: Colors.white,
      child: new FlatButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => {},
        child: new Row(
          children: <Widget>[
            new Container(
              width: 77.0,
              height: 77.0,
              color: color,
              child: new Icon(icon, color: Colors.white),
            ),
            new Expanded(
              flex: 1,
              child: new Container(
                decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(width: 0.5, color: Color(0xffdddddd))
                  ),
                ),
                child: new Row(
                  children: <Widget>[
                    new SizedBox(width: 16.0),
                    new Text(
                      text,
                      style: new TextStyle(
                        color: Color(0xff333333),
                        fontSize: 18.0,
                      ),
                    ),
                    new Expanded(flex: 1, child: new Container()),
                    new Icon(Icons.arrow_forward_ios, size: 18.0, color: Color(0xff999999)),
                    new SizedBox(width: 10.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



}

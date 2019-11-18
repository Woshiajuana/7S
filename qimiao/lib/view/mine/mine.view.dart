
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class MineView extends StatefulWidget {
  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {

  List _arrMenu = [
    {
      'text': '奇妙',
      'prompt': '拍摄的视频都在这儿哦',
      'icon': Icons.public,
    },
    {
      'text': '定格',
      'prompt': '拍摄的照片都在这儿哦',
      'icon': Icons.public,
    },
    {
      'text': '收藏',
      'prompt': '',
      'icon': Icons.public,
    },
    {
      'text': '设置',
      'prompt': '',
      'icon': Icons.public,
    },
  ];

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
                Icons.settings,
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
      padding: const EdgeInsets.only(bottom: 20.0),
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
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new FlatButton(
              onPressed: () => {},
              child: new Column(
                children: <Widget>[
                  new Text(
                    '1000',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  new SizedBox(height: 3.0),
                  new Text(
                    '关注',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
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
                children: <Widget>[
                  new Text(
                    '1000',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                  new SizedBox(height: 3.0),
                  new Text(
                    '粉丝',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
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
    return new Column(
      children: <Widget>[
        _widgetMenuItem(),
        _widgetMenuItem(),
        _widgetMenuItem(),
      ],
    );
  }

  Widget _widgetMenuItem () {
    return new Container(
      child: new FlatButton(
        onPressed: () => {},
        child: new Row(
          children: <Widget>[
            new Container(
              child: new Icon(Icons.add),
            ),
            new Text(
              '左边',
              style: new TextStyle(
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
            new Expanded(flex: 1, child: new Container()),
            new Icon(Icons.arrow_forward_ios),
          ],
        )
      ),
    );
  }



}

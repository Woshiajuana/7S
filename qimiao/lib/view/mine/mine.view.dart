
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
      child: new Column(
        children: <Widget>[
          // 头像
          new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white, width: 2.0), // 边色与边宽度
              color: Color(0xFF9E9E9E), // 底色
              borderRadius: new BorderRadius.circular((36)), // 圆角度
//            borderRadius: new BorderRadius.vertical(top: Radius.elliptical(20, 50))
            ),
            child: new ClipOval(
              child: new FadeInImage.assetNetwork(
                width: 70.0,
                height: 70.0,
                placeholder: Application.config.style.srcGoodsNull,
                image: 'http://ossmk2.jfpays.com/www_make_v1/app/static/images/defaultFace013x.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          new SizedBox(height: 5),
          // 昵称
          new Container(
            child: new Text(
              '我是阿倦啊',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          // 基本信息
          new Container(
            child: new Row(
              children: <Widget>[
                new Container(
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.add_alert),
                      new Text(
                        '979703986@qq.com',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                new Container(
                  child: new Row(
                    children: <Widget>[
                      new Icon(Icons.email, color: Colors.white),
                      new Text(
                        '979703986@qq.com',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 粉丝 or 关注
  Widget _widgetFollowSection () {
    return new Container();
  }

  // 菜单
  Widget _widgetMenuSection () {
    return new Column();
  }



}

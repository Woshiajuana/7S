
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
      height: 100.0,
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

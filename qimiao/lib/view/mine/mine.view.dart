
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
      body: new ListView(
        padding: const EdgeInsets.only(top: 0),
        children: <Widget>[
          new Container(
            height: 310,
            child: new Stack(
              children: <Widget>[
                // 头部背景
                _widgetHeaderBgSection(),
                // 头部 appbar
                _widgetAppBarSection(),
                // 头部内容
                _widgetHeaderSection(),
              ],
            ),
          ),
          // 菜单内容
          _widgetMenuSection(),
          new SizedBox(height: 20.0),
        ],
      ),
    );
  }

  // appbar
  Widget _widgetAppBarSection () {
    return new AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        new Container(
          child: new Stack(
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.email),
                onPressed: () => Application.router.push(context, 'notice'),
              ),
              new Positioned(
                top: 10.0,
                right: 10.0,
                child: new Container(
                  width: 10.0,
                  height: 10.0,
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: new BorderRadius.circular(6.0),
                    border: new Border.all(color: Colors.transparent, width: 2.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 头部背景
  Widget _widgetHeaderBgSection () {
    return new Container(
      height: 310.0,
      alignment: Alignment.bottomCenter,
      decoration: new BoxDecoration(
        color: Color(0xffdddddd),
        image: new DecorationImage(
          image: new AssetImage(Application.util.getImgPath('mine_head_bg.png')),
          fit: BoxFit.cover,
        ),
      ),
      child: new Stack(
        children: <Widget>[
          new Container(
            color: Color.fromRGBO(0, 0, 0, 0.2),
          ),
          new Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: new Container(
              height: 150.0,
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
        ],
      ),
    );
  }

  // 头部内容
  Widget _widgetHeaderSection () {
    return new Container(
      height: 310,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // 用户信息
          _widgetUserInfoSection(),
          // 用户基本信息
          _widgetFollowGroup(),
        ],
      ),
    );
  }

  Widget _widgetUserInfoSection () {
    return new Container(
      padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child:  new Column(
        children: <Widget>[
//          // 头像
//          new Container(
//            decoration: new BoxDecoration(
//              border: new Border.all(color: Colors.white, width: 2.0), // 边色与边宽度
//              color: Color(0xFF9E9E9E), // 底色
//              borderRadius: new BorderRadius.circular((41)), // 圆角度
//            ),
//            child: new ClipOval(
//              child: new FadeInImage.assetNetwork(
//                width: 80.0,
//                height: 80.0,
//                placeholder: Application.config.style.srcGoodsNull,
//                image: 'http://ossmk2.jfpays.com/www_make_v1/app/static/images/defaultFace013x.png',
//                fit: BoxFit.fill,
//              ),
//            ),
//          ),
//          new SizedBox(height: 5.0),
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
          new SizedBox(height: 12.0),
          new Container(
            height: 20.0,
            width: 70.0,
            decoration: new BoxDecoration(
              color: Application.config.style.mainColor,
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: new FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: () => {},
              child: new Text(
                '个人中心',
                style: new TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 粉丝 or 关注
  Widget _widgetFollowGroup () {
    Widget _widgetBaseInfoItem ({
      String labelText = '',
      String valueText = '',
      dynamic onPressed,
    }) {
      return new Expanded(
        flex: 1,
        child: new FlatButton(
            onPressed: onPressed,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  valueText,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                new SizedBox(height: 3.0),
                new Text(
                  labelText,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            )
        ),
      );
    }
    return new Container(
      height: 70.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _widgetBaseInfoItem(
            labelText: '粉丝',
            valueText: '1240',
          ),
          _widgetBaseInfoItem(
            labelText: '关注',
            valueText: '228',
          ),
          _widgetBaseInfoItem(
            labelText: '视频',
            valueText: '228',
            onPressed: () => Application.router.push(context, 'videoList'),
          ),
          _widgetBaseInfoItem(
            labelText: '照片',
            valueText: '55',
            onPressed: () => Application.router.push(context, 'photoList'),
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
        'useMargin': true,
        'routeName': 'videoList',
      },
      {
        'text': '照片',
        'icon': Icons.photo_camera,
        'useMargin': false,
        'routeName': 'photoList',
      },
      {
        'text': '收藏',
        'icon': Icons.favorite,
        'useMargin': true,
        'routeName': 'collectList',
      },
      {
        'text': '历史',
        'icon': Icons.history,
        'useMargin': false,
        'routeName': 'historyList',
      },
      {
        'text': '设置',
        'icon': Icons.settings,
        'useMargin': true,
        'routeName': 'setting',
      },
    ];

    Widget _widgetMenuItem ({
      dynamic onPressed,
      Color color,
      String text = '',
      IconData icon,
      bool useMargin = false,
    }) {
      return new Container(
        height: 60.0,
        margin: EdgeInsets.only(top: useMargin ? 10.0 : 0),
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(width: 0.5, color: Color(0xffdddddd)),
              top: new BorderSide(width: useMargin ? 0.5 : 0, color: Color(0xffdddddd))
          ),
        ),
        child: new FlatButton(
          padding: const EdgeInsets.all(0),
          onPressed: onPressed,
          child: new Row(
            children: <Widget>[
              new SizedBox(width: 16.0),
              new Icon(icon, color: Color(0xff666666)),
              new SizedBox(width: 16.0),
              new Text(
                text,
                style: new TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              new Expanded(flex: 1, child: new Container()),
              new Icon(Icons.arrow_forward_ios, size: 18.0, color: Color(0xff999999)),
              new SizedBox(width: 10.0),
            ],
          ),
        ),
      );
    }

    return new Column(
      children: _arrMenu.map((item) {
        return _widgetMenuItem(
          onPressed: () => Application.router.push(context, item['routeName']),
          text: item['text'],
          icon: item['icon'],
          useMargin: item['useMargin'],
        );
      }).toList(),
    );
  }

}
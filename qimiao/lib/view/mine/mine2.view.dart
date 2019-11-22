
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
      body: new CustomScrollView(
        slivers: <Widget>[

          new SliverAppBar(
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
                          border: new Border.all(color: Application.config.style.mainColor, width: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
//            title: new Text(
//              '我的',
//              style: new TextStyle(
//                fontSize: 18.0,
//              ),
//            ),
            elevation: 0,
            // 展开的高度
            expandedHeight: 310.0,
            // 强制显示阴影
            forceElevated: false,
            // 设置该属性，当有下滑手势的时候，就会显示 AppBar
            floating: false,
            // 该属性只有在 floating 为 true 的情况下使用，不然会报错
            // 当下滑到一定比例，会自动把 AppBar 展开
//            snap: true,
            // 设置该属性使 Appbar 折叠后不消失
            pinned: true,
            // 通过这个属性设置 AppBar 的背景
            flexibleSpace: new FlexibleSpaceBar(
              // 背景折叠动画
              collapseMode: CollapseMode.parallax,
              background: new Image.asset(Application.util.getImgPath('mine_head_bg.png'), fit: BoxFit.cover),
            ),
          ),
//          SliverPersistentHeader(
//            floating: false,//floating 与pinned 不能同时为true
//            pinned: true,
//            delegate: SliverPersistentHeaderDelegate.ge
//            ),
//          ),
          new SliverToBoxAdapter(
            child: new Container(
              height: 311,
              decoration: new BoxDecoration(
                color: Colors.blue,
                image: new DecorationImage(
                  image: new AssetImage(Application.util.getImgPath('mine_head_bg.png')),
                  fit: BoxFit.cover,
                ),
              ),
            ),

          ),
          // 这个部件一般用于最后填充用的，会占有一个屏幕的高度，
          // 可以在 child 属性加入需要展示的部件
          new SliverFillRemaining(
            child: new Center(
                child: new Text(
                  'content',
                  style: new TextStyle(fontSize: 30.0),
                )
            ),
          ),
        ],
      ),
    );
  }

  // 头部
  Widget _widgetHeaderSection () {
    return new Container(
      height: 311,
      decoration: new BoxDecoration(
        color: Colors.blue,
        image: new DecorationImage(
          image: new AssetImage(Application.util.getImgPath('mine_head_bg.png')),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _widgetHeaderSection1 () {
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
        'routeName': 'setting',
      },
      {
        'text': '相册',
        'icon': Icons.photo_camera,
        'color': Color(0xffd76c93),
        'routeName': 'setting',
      },
      {
        'text': '收藏',
        'icon': Icons.headset,
        'color': Color(0xff7c4a7d),
        'routeName': 'setting',
      },
      {
        'text': '设置',
        'icon': Icons.settings,
        'color': Color(0xffeacb5f),
        'routeName': 'setting',
      },
    ];

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
          onPressed: onPressed,
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

    return new Column(
      children: _arrMenu.map((item) {
        return _widgetMenuItem(
          onPressed: () => Application.router.push(context, item['routeName']),
          text: item['text'],
          icon: item['icon'],
          color: item['color'],
        );
      }).toList(),
    );
  }



}

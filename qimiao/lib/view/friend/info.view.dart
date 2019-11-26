
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:flutter/services.dart';

class FriendInfoView extends StatefulWidget {
  @override
  _FriendInfoViewState createState() => _FriendInfoViewState();
}

class _FriendInfoViewState extends State<FriendInfoView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverPersistentHeader(
            pinned: true,
            delegate: new SliverCustomHeaderDelegate(
                title: new Text(
                  '我是阿倦啊',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                collapsedHeight: 56,
                expandedHeight: 300,
                paddingTop: MediaQuery.of(context).padding.top,
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(
                <Widget>[
                  _widgetMenuSection(),
                  _widgetMenuSection(),
                  _widgetMenuSection(),
                  _widgetMenuSection(),
                ]
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

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;

  final Widget title; // 标题
  final Widget leading; // 返回
  final List<Widget> actions; // 右边图标
  final Widget background;
  final Widget child;

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.title,
    this.actions,
    this.leading,
    this.background,
    this.child,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  void updateStatusBarBrightness(shrinkOffset) {
    if(shrinkOffset > 50) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
    } else if(shrinkOffset <= 50) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 236, 100, 47);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if(shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 255, 255, 255);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    this.updateStatusBarBrightness(shrinkOffset);
    return new Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[

          // 背景图
          background ?? new Container(),

          child ?? new Container(),
//
//          // mask
//          new Positioned(
//            left: 0,
//            top: this.maxExtent / 2,
//            right: 0,
//            bottom: 0,
//            child: new Container(
//              decoration: new BoxDecoration(
//                gradient: new LinearGradient(
//                  begin: Alignment.topCenter,
//                  end: Alignment.bottomCenter,
//                  colors: [
//                    Color(0x00000000),
//                    Color(0x90000000),
//                  ],
//                ),
//              ),
//            ),
//          ),

          // 头部导航条
          new Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: new Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: new SafeArea(
                bottom: false,
                child: new Container(
                  height: this.collapsedHeight,
                  child: new Row(
                    children: <Widget>[
                      leading ?? new IconButton(
                        icon: new Icon(
                          Icons.arrow_back,
                          color: this.makeStickyHeaderTextColor(shrinkOffset, true),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      new SizedBox(width: 24.0),
                      title ?? new Container(),
                      new Expanded(child: new Container(), flex: 1),
                      new Container(
                        width: 100,
                        height: this.maxExtent,
                        child: new Stack(
                          children: actions ?? <Widget>[],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
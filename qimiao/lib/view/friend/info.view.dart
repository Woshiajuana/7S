
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
              expandedHeight: 310,
              paddingTop: MediaQuery.of(context).padding.top,
              background: _widgetHeaderBgSection(),
              child: _widgetHeaderSection(),
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
      padding: const EdgeInsets.only(bottom: 16.0),
      child:  new Column(
        children: <Widget>[
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
          new SizedBox(height: 3.0),
          new Text(
            '这个家伙什么都没留下...',
            style: new TextStyle(
              color: Color(0xffbbbbbb),
              fontSize: 12.0,
            ),
          ),
          new SizedBox(height: 12.0),
        ],
      ),
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
      margin: const EdgeInsets.only(bottom: 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _widgetBaseInfoItem(
            labelText: '粉丝',
            valueText: '1240',
            onPressed: () => Application.router.push(context, 'friend'),
          ),
          _widgetBaseInfoItem(
            labelText: '关注',
            valueText: '228',
            onPressed: () => Application.router.push(context, 'friend'),
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
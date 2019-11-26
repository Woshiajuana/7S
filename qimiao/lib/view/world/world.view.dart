
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:flukit/flukit.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new SafeArea(
        bottom: false,
        child: new DefaultTabController(
          length: 2,
          child: new NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                // 搜索
                _widgetSearchSection(),
                new SliverPersistentHeader(
                  pinned: true,
                  delegate: new StickyWidgetDelegate(
                    height: 50.0,
                    child: new Container(
                      height: 50.0,
                      color: Colors.white,
                      child: TabBar(
                        labelColor: Theme.of(context).primaryColor,
                        labelStyle: TextStyle(fontSize: 16.5),
                        unselectedLabelColor: Color.fromARGB(255, 192, 193, 195),
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorWeight: 2.0,
                        tabs: <Widget>[
                          new Tab(
                            child: new Text('1'),
                          ),
                          new Tab(
                            child: new Text('2'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: TabBarView(
              children: <Widget>[
                new RefreshIndicator(
                  child: new ListView(
                    children: <Widget>[
                      new Container(height: 100, color: Colors.red),
                      new Container(height: 100, color: Colors.blue),
                      new Container(height: 100, color: Colors.red),
                      new Container(height: 100, color: Colors.blue),
                    ],
                  ),
                  onRefresh: _onRefresh,
                ),
                new ListView(
                  children: <Widget>[
                    new Container(height: 100, color: Colors.green),
                    new Container(height: 100, color: Colors.yellow),
                    new Container(height: 100, color: Colors.green),
                    new Container(height: 100, color: Colors.yellow),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 下拉刷新方法,为list重新赋值
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh');

    });
  }

  // 搜索
  Widget _widgetSearchSection () {
    return new SliverToBoxAdapter(
      child: new Container(
        height: 50.0,
        child: new Row(
          children: <Widget>[
            new SizedBox(width: 16.0),
            new Expanded(
              flex: 1,
              child: new Container(
                height: 30,
                decoration: new BoxDecoration(
                  color: Color(0xfff2f2f2),
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                child: new FlatButton(
                  onPressed: () => {},
                  padding: const EdgeInsets.all(0),
                  child: new Row(
                    children: <Widget>[
                      new SizedBox(width: 12.0),
                      new Icon(Icons.search, size: 18.0, color: Color(0xff999999)),
                      new SizedBox(width: 10.0),
                      new Text(
                        '什么？找不到你想要的？试试我吧...',
                        style: new TextStyle(
                          color: Color(0xff999999),
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            new Container(
              width: 40.0,
              height: 40.0,
              child: new FlatButton(
                onPressed: () => {},
                padding: const EdgeInsets.all(5.0),
                child: new Image.asset(
                  Application.util.getImgPath('scan-icon.png'),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  color: Application.config.style.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // appbar
  Widget _widgetAppBarSection () {
    return new Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: new Container(
        color: Colors.transparent,
        child: new SafeArea(
          bottom: false,
          child: new Container(
            height: 56.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Container(
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.email, color: Colors.white),
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
            ),
          ),
        ),
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

  // 头部内容
  Widget _widgetHeaderSection () {
    return new Container(
      height: 310,
      child: new ListView(
        reverse: true,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // 用户信息
              _widgetUserInfoSection(),
              // 用户基本信息
              _widgetFollowGroup(),
            ],
          ),
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
          new Container(
            height: 20.0,
            width: 70.0,
            decoration: new BoxDecoration(
              color: Application.config.style.mainColor,
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: new FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: () => Application.router.push(context, 'mineCenter'),
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
        'useMargin': true,
        'routeName': 'videoList',
      },
      {
        'text': '照片',
        'icon': Icons.photo,
        'useMargin': false,
        'routeName': 'photoList',
      },
      {
        'text': '收藏',
        'icon': Icons.star,
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
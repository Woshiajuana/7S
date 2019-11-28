
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';

class FriendInfoView extends StatefulWidget {
  @override
  _FriendInfoViewState createState() => _FriendInfoViewState();
}

class _FriendInfoViewState extends State<FriendInfoView> {

  TabController tabController;

  @override
  Widget build(BuildContext context) {
    final List<Color> colorList = [
      Colors.red,
      Colors.orange,
      Colors.green,
//      Colors.purple,
//      Colors.blue,
//      Colors.yellow,
//      Colors.pink,
//      Colors.teal,
//      Colors.deepPurpleAccent,
//      Colors.red,
//      Colors.orange,
//      Colors.green,
//      Colors.purple,
//      Colors.blue,
//      Colors.yellow,
//      Colors.pink,
//      Colors.teal,
//      Colors.deepPurpleAccent,
    ];
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      body: new DefaultTabController(
        length: 2,
        child: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
//              new SliverOverlapAbsorber(
//                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//                child:  new SliverPersistentHeader(
//                  pinned: true,
//                  delegate: new SliverCustomHeaderDelegate(
//                      collapsedHeight: 56,
//                      expandedHeight: 310,
//                      paddingTop: MediaQuery.of(context).padding.top,
//                      buildContent: (BuildContext context, double shrinkOffset, int alpha) {
//                        return <Widget> [
//                          _widgetHeaderBgSection(),
//                          _widgetHeaderSection(shrinkOffset: shrinkOffset, alpha: alpha),
//                          _widgetAppBarSection(shrinkOffset: shrinkOffset, alpha: alpha),
//                        ];
//                      }
//                  ),
//                ),
//              ),

              new SliverPersistentHeader(
                pinned: true,
                delegate: new SliverCustomHeaderDelegate(
                    collapsedHeight: 56,
                    expandedHeight: 310,
                    paddingTop: MediaQuery.of(context).padding.top,
                    buildContent: (BuildContext context, double shrinkOffset, int alpha) {
                      return <Widget> [
                        _widgetHeaderBgSection(),
                        _widgetHeaderSection(shrinkOffset: shrinkOffset, alpha: alpha),
                        _widgetAppBarSection(shrinkOffset: shrinkOffset, alpha: alpha),
                      ];
                    }
                ),
              ),

              new SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: new SliverPersistentHeader(
                  pinned: true,
                  delegate: new StickyTabBarDelegate(
                    child: new TabBar(
                      unselectedLabelColor: Color(0xff999999),
                      labelColor: Application.config.style.mainColor,
                      indicatorColor: Application.config.style.mainColor,
                      tabs: <Widget>[
                        Tab(text: '视频'),
                        Tab(text: '照片'),
                      ],
                    ),
                  ),
                ),
              ),

            ];
          },
          body: new Container(
            padding: const EdgeInsets.only(top: 56.0),
            child: new TabBarView(
              children: <Widget>[
                Builder(
                  builder: (context) =>  new CustomScrollView(
                    slivers: <Widget>[
                      // 将子部件同 `SliverAppBar` 重叠部分顶出来，否则会被遮挡
                      SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                      new SliverList(
                        delegate: SliverChildListDelegate(
                            <Widget> [
                              _widgetVideoGroup(),
                              _widgetVideoGroup(),

                            ]
                        ),
                      ),
                    ],
                  ),
                ),
                new RefreshIndicator(
                  child: new ListView(
                    children: <Widget>[
                      _widgetVideoGroup(),
                      new SizedBox(height: 10.0),
                    ],
                  ),
                  onRefresh: _onRefresh,
                ),

              ],
            ),
          ),
        )
      ),
    );
  }

  // 下拉刷新方法,为list重新赋值
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh');

    });
  }

  // 视频内容
  Widget _widgetVideoGroup () {

    Widget _widgetVideoItem () {
      double width = (MediaQuery.of(context).size.width - 30) / 2;
      return new Container(
        width: width,
        margin: const EdgeInsets.only(top: 10.0),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(6.0),
          boxShadow: [
            new BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                blurRadius: 1.0, //阴影模糊程度
                spreadRadius: 1.0 //阴影扩散程度
            )
          ],
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              width: width,
              height: width * 0.6,
              child: new Stack(
                children: <Widget>[
                  new Container(
                    child: new ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: new Image.asset(
                        Application.util.getImgPath('guide1.png'),
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      borderRadius: new BorderRadius.circular(6.0),
                    ),
                  ),
                  new Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: new Container(
                      height: 30.0,
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
                    padding: const EdgeInsets.only(bottom: 5.0, left: 10.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                            new Expanded(child: new Container(), flex: 1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new SizedBox(height: 5.0),
            new Container(
              height: 34.0,
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: new Text(
                '你打扫第几啊宋迪你你打扫第几啊宋迪你迪迪',
                style: new TextStyle(
                  color: Color(0xff333333),
                  fontSize: 12.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            new SizedBox(height: 3.0),
            new Container(
              padding: const EdgeInsets.only(left: 10.0, right: 5.0),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Text(
                      '我是阿倦啊',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: Color(0xff999999),
                      ),
                    ),
                    flex: 1,
                  ),
                  new Container(
                    height: 20.0,
                    width: 20.0,
                    child: new FlatButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => _handleOperate(),
                        child: new Icon(Icons.more_vert, size: 18.0, color: Color(0xff999999))
                    ),
                  ),
                ],
              ),
            ),
            new SizedBox(height: 8.0),
          ],
        ),
      );
    }
    return new Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: new Wrap(
        spacing: 10.0, // gap between adjacent chips
        runSpacing: 10.0,
        children: <Widget>[
//          _widgetVideoItem(),
//          _widgetVideoItem(),
//          _widgetVideoItem(),
//          _widgetVideoItem(),
//          _widgetVideoItem(),
//          _widgetVideoItem(),
          _widgetVideoItem(),
          _widgetVideoItem(),
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
              'text': '分享',
              'onPressed': () {
                print('相册1');
              },
            },
            {
              'text': '举报',
              'onPressed': () => print('拍照'),
            },
          ],
        );
      },
    );
  }

  // 导航条
  Widget _widgetAppBarSection ({
    double shrinkOffset,
    int alpha,
  }) {
    return new Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: new Container(
        color: Color.fromARGB(alpha, 236, 100, 47),
        child: new SafeArea(
          bottom: false,
          child: new Container(
            height: 56.0,
            child: new Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    color: shrinkOffset <= 50 ? Colors.white : Color.fromARGB(alpha, 255, 255, 255),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                new SizedBox(width: 24.0),
                new Text(
                  '我是阿倦啊',
                  style: new TextStyle(
                    color: shrinkOffset <= 50 ? Colors.transparent : Color.fromARGB(alpha, 255, 255, 255),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 头部内容
  Widget _widgetHeaderSection ({
    double shrinkOffset,
    int alpha,
  }) {
    return new Container(
      height: 310,
      child: new ListView(
        reverse: true,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // 用户信息
              _widgetUserInfoSection(
                shrinkOffset: shrinkOffset,
                alpha: alpha,
              ),
              // 用户基本信息
              _widgetFollowGroup(
                shrinkOffset: shrinkOffset,
                alpha: alpha,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetUserInfoSection ({
    double shrinkOffset,
    int alpha,
  }) {
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
                    color: Color.fromARGB(255 - alpha, 255, 255, 255),
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
              color: Color.fromARGB(255 - alpha, 187, 187, 187),
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
  Widget _widgetFollowGroup ({
    double shrinkOffset,
    int alpha,
  }) {
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
                    color: Color.fromARGB(255 - alpha, 255, 255, 255),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                new SizedBox(height: 3.0),
                new Text(
                  labelText,
                  style: new TextStyle(
                    color: Color.fromARGB(255 - alpha, 255, 255, 255),
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
          ),
          _widgetBaseInfoItem(
            labelText: '关注',
            valueText: '228',
          ),
          _widgetBaseInfoItem(
            labelText: '视频',
            valueText: '228',
          ),
          _widgetBaseInfoItem(
            labelText: '照片',
            valueText: '55',
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

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
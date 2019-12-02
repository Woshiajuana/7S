
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class WorldView extends StatefulWidget {
  @override
  _WorldViewState createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.mainColor,
      body: new SafeArea(
        bottom: false,
        child: new Container(
          color: Application.config.style.backgroundColor,
          child: new DefaultTabController(
            length: 3,
            child: new NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  // 搜索
                  _widgetSearchSection(),
                  // tab 切换条
                  _widgetTabSection(context),
                ];
              },
              body: new Container(
                padding: const EdgeInsets.only(top: 40.0),
                child: new TabBarView(
                  children: <Widget>[
                    new RefreshIndicator(
                      child: new ListView(
                        children: <Widget>[
                          _widgetCarouselCell(),
                          _widgetVideoGroup(),
                          new SizedBox(height: 10.0),
                        ],
                      ),
                      onRefresh: _onRefresh,
                    ),
                    new ListView(
                      children: <Widget>[
                        _widgetVideoGroup(),
                        new SizedBox(height: 10.0),
                      ],
                    ),
                    new ListView(
                      children: <Widget>[
                        _widgetVideoGroup(),
                        new SizedBox(height: 10.0),
                      ],
                    ),
                  ],
                ),
              ),
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
        height: 56.0,
        color: Application.config.style.mainColor,
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
                  onPressed: () => Application.router.push(context, 'search'),
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
                          fontWeight: FontWeight.w400,
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
                padding: const EdgeInsets.all(8.0),
                child: new Image.asset(
                  Application.util.getImgPath('scan-icon.png'),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // tab 切换
  Widget _widgetTabSection (BuildContext context) {
    return new SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      child: new SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: new StickyWidgetDelegate(
          maxExtentHeight: 40.0,
          minExtentHeight: 40.0,
          child: new Container(
            height: 40.0,
            decoration: new BoxDecoration(
              color: Application.config.style.mainColor,
              border: new Border(
                bottom: new BorderSide(
                  color: Color(0xffdddddd),
                  width: 0.5,
                ),
              ),
            ),
            child: new TabBar(
              labelColor: Colors.white,
              labelStyle: new TextStyle(
                fontSize: 18.0,
              ),
              unselectedLabelStyle: new TextStyle(
                fontSize: 14.0,
              ),
              unselectedLabelColor: Color(0xffdddddd),
              indicatorColor: Application.config.style.mainColor,
              indicatorWeight: 0.1,
              tabs: <Widget>[
                new Tab(
                  child: new Text(
                    '推荐',
                  ),
                ),
                new Tab(
                  child: new Text(
                    '视频一瞬',
                  ),
                ),
                new Tab(
                  child: new Text(
                    '精彩一刻',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 轮播图
  Widget _widgetCarouselCell () {
    // 引导页数据
    List<String> _arrGuide = [
      Application.util.getImgPath('guide1.png'),
      Application.util.getImgPath('guide2.png'),
      Application.util.getImgPath('guide3.png'),
      Application.util.getImgPath('guide4.png'),
    ];
    return new Container(
      height: 160.0,
      margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      decoration: new BoxDecoration(
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
      child: new Swiper(
        autoStart: true,
        circular: true,
        indicator: new CircleSwiperIndicator(
          radius: 4.0,
          padding: const EdgeInsets.only(bottom: 10.0),
          itemColor: Colors.black26,
          itemActiveColor: Application.config.style.mainColor,
        ),
        children:_arrGuide.map((item) {
          return new Container(
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: new Image.asset(
                item,
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          );
        }).toList(),
      ),
    );
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
          _widgetVideoItem(),
          _widgetVideoItem(),
          _widgetVideoItem(),
          _widgetVideoItem(),
          _widgetVideoItem(),
          _widgetVideoItem(),
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

}
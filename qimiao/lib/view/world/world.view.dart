
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
      body:  new SafeArea(
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
                  _widgetTabSection(),
                ];
              },
              body: new Container(
                padding: const EdgeInsets.only(top: 40.0),
                child: TabBarView(
                  children: <Widget>[
                    new RefreshIndicator(
                      child: new ListView(
                        padding: const EdgeInsets.all(0),
                        children: <Widget>[
                          new Container(height: 100, color: Colors.blue),
                          _widgetCarouselCell(),
                        ],
                      ),
                      onRefresh: _onRefresh,
                    ),
                    new ListView(
                      children: <Widget>[
                        new Container(height: 100, color: Colors.blue),
                        new Container(height: 100, color: Colors.white10),
                        new Container(height: 100, color: Colors.yellow),
                        new Container(height: 100, color: Colors.green),
                        new Container(height: 100, color: Colors.yellow),
                      ],
                    ),
                    new ListView(
                      children: <Widget>[
                        new Container(height: 100, color: Colors.blue),
                        new Container(height: 100, color: Colors.white10),
                        new Container(height: 100, color: Colors.white10),
                        new Container(height: 100, color: Colors.white10),
                        new Container(height: 100, color: Colors.white10),
                        new Container(height: 100, color: Colors.white10),
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
  Widget _widgetTabSection () {
    return new SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: new StickyWidgetDelegate(
        height: 40.0,
        child: new Container(
          height: 40.0,
          decoration: new BoxDecoration(
//            color: Application.config.style.mainColor,
            border: new Border(
              bottom: new BorderSide(
                color: Color(0xffdddddd),
                width: 0.5,
              )
            )
          ),
          child: new TabBar(
            labelColor: Colors.white,
            labelStyle: new TextStyle(fontSize: 16.5),
            unselectedLabelColor: Color(0xffdddddd),
            indicatorColor: Colors.white,
            indicatorWeight: 1.0,
            tabs: <Widget>[
              new Tab(
                child: new Text(
                  '推荐',
                  style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              new Tab(
                child: new Text(
                  '视频一瞬',
                   style: new TextStyle(
                     fontSize: 16.0,
                     fontWeight: FontWeight.w400,
                   ),
                ),
              ),
              new Tab(
                child: new Text(
                  '精彩一刻',
                  style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
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
      margin: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        border: new Border.all(color: Color(0xffdddddd), width: 0.5),
        borderRadius: new BorderRadius.circular(6.0),
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


}
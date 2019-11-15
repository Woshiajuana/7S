
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:qimiao/view/home/home.view.dart';
import 'package:qimiao/view/demo/demo.view.dart';
import 'package:qimiao/view/util/util.view.dart';
import 'package:qimiao/common/application.dart';

class AppView extends StatefulWidget {

  @override
  _AppViewState createState() => new _AppViewState();
}

class _AppViewState extends State<AppView> with SingleTickerProviderStateMixin {

  // Tab页面
  List _arrTab = [
    {
      'text': '世界',
      'icon': Icons.public,
    },
    {
      'text': '日历',
      'icon': Icons.calendar_today,
    },
    {
      'text': '我的',
      'icon': Icons.face,
    },
  ];
  // Tab页的控制器，可以用来定义Tab标签和内容页的坐标
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      length: _arrTab.length, // Tab页的个数
      vsync: this, // 动画效果的异步处理，默认格式
    );
    _pageController = new PageController(
      initialPage: 0,
    );
    Application.context = context;
  }

  // 组件即将销毁时调用
  @override
  void dispose() {
    // 释放内存，节省开销
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // 生命周期方法构建Widget时调用
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          '7S',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: <Widget>[
          new Container(
            width: 60.0,
            child: new FlatButton(
              onPressed: () => {},
              padding: const EdgeInsets.all(0),
              child: new Icon(
                Icons.search,
                size: 28.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: new PageView(
        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),
        children: <Widget>[
          new HomeView(),
          new DemoView(),
          new UtilView(),
        ],
      ),
      bottomNavigationBar: new Container(
        decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(
                color: Color(0xffdddddd),
                width: 0.5,
              )
          ),
        ),
        child: new Material(
          color: Colors.white,
          elevation: 0.0,
          child: _widgetTabBar(),
        ),
      ),
    );
  }

  Widget _widgetTabBar () {
    List<Widget> tabs = _arrTab.map((item) {
      return new Tab(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(item['icon'], size: 24.0,),
            new Text(item['text'], style: new TextStyle(fontSize: 10.0,),)
          ],
        ),
      );
    }).toList();
    return new TabBar(
      indicatorColor: Colors.white,
      controller: _tabController,
      tabs: tabs,
      labelColor: Application.config.style.mainColor,
      unselectedLabelColor: Application.config.style.unselectedLabelColor,
      onTap: (index) {
        _pageController.jumpToPage(index);
      },
    );
  }

  static Future<void> pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

}
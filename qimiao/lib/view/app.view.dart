
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:qimiao/view/world/world.view.dart';
import 'package:qimiao/view/mine/mine.view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qimiao/view/freezeFrame/freezeFrame.view.dart';
import 'package:qimiao/common/common.dart';
import 'package:qimiao/model/model.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:package_info/package_info.dart';

class AppView extends StatefulWidget {

  @override
  _AppViewState createState() => new _AppViewState();
}

class _AppViewState extends State<AppView> with SingleTickerProviderStateMixin {
  static int lastExitTime = 0;

  // Tab页面
  List _arrTab = [
    {
      'text': '世界',
      'icon': Icons.public,
    },
    {
      'text': '定格',
      'icon': Icons.camera_enhance,
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
    this._reqVersionCheck();
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
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        body: new PageView(
          controller: _pageController,
          physics: new NeverScrollableScrollPhysics(),
          children: <Widget>[
            new WorldView(),
            new FreezeFrameView(),
            new MineView(),
          ],
        ),
        bottomNavigationBar: new Container(
          decoration: new BoxDecoration(
            border: new Border(
              top: new BorderSide(
                color: Color(0xffdddddd),
                width: 0.5,
              ),
            ),
          ),
          child: new Material(
            color: Colors.white,
            elevation: 0.0,
            child: _widgetTabBar(),
          ),
        ),
      ),
    );
  }

  // 自定义返回键事件 一定时间内点击两次退出，反之提示
  Future<bool> _onBackPressed() async {
    int nowExitTime = DateTime.now().millisecondsSinceEpoch;
    if(nowExitTime - lastExitTime > 2000) {
      lastExitTime = nowExitTime;
      Fluttertoast.showToast(
          msg: '再按一次退出程序',
          gravity: ToastGravity.BOTTOM,
      );
      return await Future.value(false);
    }
    return await Future.value(true);
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

  void _reqVersionCheck () async {
    await Future.delayed(Duration(milliseconds: 0)).then((e) async{
      try {
        String strUrl = Application.config.api.reqVersionCheck;
        var data = await Application.util.http.post(strUrl, params: {
          'platform': Platform.isIOS ? 'iOS' : 'android'
        }, useLoading: false);
        if (data != null) {
          VersionJsonModel versionJsonModel = VersionJsonModel.fromJson(data);
          PackageInfo packageInfo = await PackageInfo.fromPlatform();
          String version = packageInfo.version;
          bool isForceUpdate = false;
          bool isUpdate = false;
          String maxVersion = versionJsonModel.version ?? '';
          String minVersion = versionJsonModel.minVersion ?? '';
          if (maxVersion != '') {
            isUpdate = _compareVersion(maxVersion, version);
          }
          if (minVersion != '') {
            isForceUpdate = _compareVersion(minVersion, version);
          }

          if (isForceUpdate || isUpdate) {
            await showDialog(
              context: context,
              builder: (BuildContext buildContext) {
                return new WillPopScope(
                    child: new UpgradeDialog(
                      url: versionJsonModel.address,
                      isForce: isForceUpdate,
                      arrContent: versionJsonModel.content,
                    ),
                    onWillPop: () async {
                      return Future.value(false);
                    }
                );
              },
            );
          }
        }
      } catch (err) {
        print(err);
//        Application.util.modal.toast(err);
      }
    });
  }

  bool _compareVersion (String v1, String v2) {
    List<String> arrV1 = v1.split('.');
    List<String> arrV2 = v2.split('.');
    return int.parse(arrV1[0]) > int.parse(arrV2[0])
    || int.parse(arrV1[1]) > int.parse(arrV2[1])
    || int.parse(arrV1[2]) > int.parse(arrV2[2]);
  }

}
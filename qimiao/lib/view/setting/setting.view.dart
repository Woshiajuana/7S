
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';
import 'package:qimiao/model/model.dart';
import 'package:package_info/package_info.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '设置',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          _widgetMenuSection(),
          _widgetExitButtonSection(),
        ],
      ),
    );
  }

  // 菜单组
  Widget _widgetMenuSection () {
    List _arrMenu = [
      {
        'useMargin': false,
        'text': '修改密码',
        'routeName': 'passwordChange',
      },
//      {
//        'useMargin': false,
//        'text': '登录设备管理',
//        'routeName': 'device',
//      },
      {
        'useMargin': true,
        'text': '关于我们',
        'routeName': 'about',
      },
      {
        'useMargin': false,
        'text': '检测更新',
        'onPressed': _handleCheckVersion,
      },
      {
        'useMargin': true,
        'text': '帮助',
        'routeName': 'webview',
        'params': { 'title': '帮助', 'url': 'http://154.8.209.13:23335/fqa.html?application=5db1540c5db6a60c11331963' },
      },
      {
        'useMargin': false,
        'text': '反馈',
        'routeName': 'webview',
        'params': { 'title': '帮助', 'url': 'http://154.8.209.13:23335/feedback.html?application=5db1540c5db6a60c11331963' },
      },
    ];
    Widget _widgetMenuItem ({
      dynamic onPressed,
      String text,
      bool useMargin = false,
    }) {
      return new Container(
        height: 60,
        margin: EdgeInsets.only(top: useMargin ? 10.0 : 0),
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
            bottom: new BorderSide(color: Color(0xffdddddd), width: 0.5),
          ),
        ),
        child: new FlatButton(
          onPressed: onPressed,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                text,
                style: new TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              new Icon(Icons.arrow_forward_ios, size: 18.0, color: Color(0xff999999)),
            ],
          ),
        ),
      );
    }
    return new Column(
      children: _arrMenu.map((item) {
        return _widgetMenuItem(
          onPressed: () {
            if (item['routeName'] != null)
              Application.router.push(context, item['routeName'], params: item['params']);
            else if  (item['onPressed'] != null)
              item['onPressed']();
          },
          text: item['text'],
          useMargin: item['useMargin'],
        );
      }).toList(),
    );
  }

  // 安全退出
  Widget _widgetExitButtonSection () {
    return new Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 30.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          top: new BorderSide(color: Color(0xffdddddd), width: 0.5),
          bottom: new BorderSide(color: Color(0xffdddddd), width: 0.5),
        ),
      ),
      child: new FlatButton(
        onPressed: () => _handleExitOut(),
        child: new Text(
          '安全退出',
          style: new TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void _handleExitOut () async {
    var result = await showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return new ConfirmDialog(
          content: '确定要退出此账号吗？',
        );
      },
    );
    if (result != true) return;
    try {
      String userJsonKey = Application.config.store.userJson;
      await Application.util.store.remove(userJsonKey);
    } catch (err) {

    } finally {
      Application.router.root(context, 'login');
    }
  }

  void _handleCheckVersion () async {
    try {
      String strUrl = Application.config.api.reqVersionCheck;
      var data = await Application.util.http.post(strUrl, params: {
        'platform': Platform.isIOS ? 'iOS' : 'android'
      });
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
      } else {
        Application.util.modal.toast('已是最新版本');
      }
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }

  bool _compareVersion (String v1, String v2) {
    List<String> arrV1 = v1.split('.');
    List<String> arrV2 = v2.split('.');
    return int.parse(arrV1[0]) > int.parse(arrV2[0])
        || int.parse(arrV1[1]) > int.parse(arrV2[1])
        || int.parse(arrV1[2]) > int.parse(arrV2[2]);
  }

}

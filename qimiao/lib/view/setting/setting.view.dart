
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/widget/widget.dart';

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
        'text': '登录设备管理',
      },
      {
        'useMargin': true,
        'text': '关于7S',
      },
      {
        'useMargin': false,
        'text': '检测更新',
      },
      {
        'useMargin': true,
        'text': '帮助',
      },
      {
        'useMargin': false,
        'text': '反馈',
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
          onPressed: () => {},
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
            fontSize: 18.0,
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
          content: '您确定要退出此账号吗？',
        );
      },
    );
    if (result != true) return;
    try {
//      await Application.util.store.clear();
    } catch (err) {

    } finally {
      Application.router.replace(context, '/');
    }
  }

}

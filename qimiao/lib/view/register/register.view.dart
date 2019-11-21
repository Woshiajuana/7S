
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/common/utils/timer.util.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  String _strEmail; // 邮箱
  String _strPassword; // 密码
  String _strCode; // 验证码
  int _numDefCount = 10;
  int _numCount = 10;
  TimerUtil _timerUtil;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '注册',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.blue,
          image: new DecorationImage(
            image: new AssetImage(Application.util.getImgPath('register_bg.jpg')),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(
          children: <Widget>[
            _widgetMaskSection(),

          ],
        ),
      )
    );
  }

  // 背景mask
  Widget _widgetMaskSection () {
    return new Container(
      color: Color.fromRGBO(255,255,255,0.86),
    );
  }

  // 倒计时
  void _countDown () {
    _timerUtil = new TimerUtil(mTotalTime: _numCount * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _numCount = _tick.toInt();
      });
      if (_tick == 0) {
        setState(() {
          _numCount = _numDefCount;
        });
        _timerUtil.cancel();
      }
    });
    _timerUtil.startCountDown();
  }

  // 登录
  Widget _widgetButtonSection () {
    return new Container(
      height: 45.0,
      margin: const EdgeInsets.only(left: 60.0, right: 60.0, top: 60.0),
      decoration: new BoxDecoration(
        color: Application.config.style.mainColor,
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: new FlatButton(
        onPressed: () => {},
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '注册',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 协议
  Widget _widgetAgreementSection () {
    return new Positioned(
      bottom: 30.0,
      left: 0,
      right: 0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            '完成注册即代表您同意',
          ),
          new InkWell(
            onTap: () => Application.router.push(context, 'webview', params: { 'title': '用户协议', 'url': 'https://www.baidu.com' }),
            child: new Text(
              '用户协议',
              style: TextStyle(color: Application.config.style.mainColor),
            ),
          ),
          new Text(
            '和',
          ),
          new InkWell(
            onTap: () => Application.router.push(context, 'webview', params: { 'title': '隐私政策', 'url': 'http://www.owulia.com' }),
            child: new Text(
              '隐私政策',
              style: TextStyle(color: Application.config.style.mainColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_timerUtil != null) _timerUtil.cancel(); // 记得中dispose里面把timer cancel。
    super.dispose();
  }


}

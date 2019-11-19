
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
      body: new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              new SizedBox(height: 20.0),
              new Container(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: new TextFormField(
                  decoration: new InputDecoration(
                    labelText: '邮箱',
                  ),
                  validator: (String value) { return value; },
                  onSaved: (String value) => _strEmail = value,
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: '验证码',
                        ),
                        validator: (String value) { return value; },
                        onSaved: (String value) => _strEmail = value,
                      ),
                    ),
                    new SizedBox(width: 20.0),
                    new Container(
                      width: 100,
                      height: 45,
                      decoration: new BoxDecoration(
                        color: _numCount == _numDefCount ? Application.config.style.mainColor : Color(0xff999999),
                        borderRadius: new BorderRadius.circular(6.0),
                      ),
                      child: new FlatButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => _countDown(),
                        child: new Text(
                          _numCount == _numDefCount ? '发送验证码' : '$_numCount s',
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: new TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                    labelText: '密码',
                  ),
                  validator: (String value) { return value; },
                  onSaved: (String value) => _strPassword = value,
                ),
              ),
              _widgetButtonSection(),
            ],
          ),
          _widgetAgreementSection(),
        ],
      )
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
            onTap: () => Application.router.push(context, 'register'),
            child: new Text(
              '用户协议',
              style: TextStyle(color: Application.config.style.mainColor),
            ),
          ),
          new Text(
            '和',
          ),
          new InkWell(
            onTap: () => Application.router.push(context, 'register'),
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

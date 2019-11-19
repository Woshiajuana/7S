
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class LoginView extends StatefulWidget {

  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  String _username = '13127590698';
  String _password = '111111';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              _widgetHeaderSection(),
              _widgetInputSection(),
              _widgetForgetSection(),
              _widgetButtonSection(),
            ],
          ),
          _widgetRegisterLinkSection(),
        ],
      ),
    );
  }

  // 头部 LOGO
  Widget _widgetHeaderSection () {
    return new Container(
      margin: const EdgeInsets.only(top: 70.0),
      child: new Image.asset(
        Application.util.getImgPath('logo-300'),
        width: 120.0,
        height: 120.0,
      ),
    );
  }

  // 输入
  Widget _widgetInputSection () {
    String _strEmail;
    String _strPassword;
    bool _isObscure = false;
    return new Container(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: new Column(
        children: <Widget>[
          new TextFormField(
            decoration: new InputDecoration(
              labelText: '邮箱',
            ),
            validator: (String value) { return value; },
            onSaved: (String value) => _strEmail = value,
          ),
          new SizedBox(height: 20.0),
          new TextFormField(
            obscureText: _isObscure,
            decoration: new InputDecoration(
              labelText: '密码',
            ),
            validator: (String value) { return value; },
            onSaved: (String value) => _strPassword = value,
          ),
        ],
      ),
    );
  }

  // 忘记密码
  Widget _widgetForgetSection () {
    return new Container(
      padding: const EdgeInsets.only(right: 30.0, top: 15.0),
      child: new Align(
        alignment: Alignment.centerRight,
        child: new InkWell(
          onTap: () => {},
          child: new Text(
            '忘记密码？',
            style: new TextStyle(
              fontSize: 14.0,
              color: Color(0xff333333),
            ),
          ),
        ),
      ),
    );
  }

  // 注册
  Widget _widgetRegisterLinkSection () {
    return new Positioned(
      bottom: 30.0,
      left: 0,
      right: 0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            '没有账号？ ',
          ),
          new InkWell(
            onTap: () => {},
            child: new Text(
              '点击注册',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  // 登录
  Widget _widgetButtonSection () {
    return new Container(
      height: 45.0,
      margin: const EdgeInsets.only(left: 60.0, right: 60.0, top: 60.0),
      decoration: new BoxDecoration(
        color: Colors.blue,
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: new FlatButton(
        onPressed: () => {},
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '登录',
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

  // 提交
  void _handleSubmit() async {

  }
}
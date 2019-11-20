
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class LoginView extends StatefulWidget {

  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  String _strEmail;
  String _strPassword;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.blue,
          image: new DecorationImage(
            image: new AssetImage(Application.util.getImgPath('login_bg.jpg')),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(
          children: <Widget>[
            _widgetMaskSection(),
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
      ),
    );
  }


  // 背景mask
  Widget _widgetMaskSection () {
    return new Container(
      color: Color.fromRGBO(0, 0, 0, 0.5),
    );
  }

  // 头部 LOGO
  Widget _widgetHeaderSection () {
    return new Container(
      margin: const EdgeInsets.only(top: 70.0),
      child: new Image.asset(
        Application.util.getImgPath('login_logo.png'),
        width: 67.0,
        height: 115.0,
      ),
    );
  }

  // 输入框
  Widget _widgetInputSection () {
    return new Center(
      child: new Container(
        width: 260.0,
        height: 46.0,
        decoration: new BoxDecoration(
          color: Color(0xffe4e3e0),
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: new Row(
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              width: 46.0,
              height: 46.0,
              child: new Image.asset(Application.util.getImgPath('user_icon.png'), width: 16.0, height: 16.0),
            ),
            new Expanded(
              flex: 1,
              child: new TextFormField(
                decoration: new InputDecoration(
                  hintText: '请输入用户名',
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onSaved: (String value) => _strEmail = value,
              ),
            ),
            new Offstage(
              offstage: false,
              child: new IconButton(
                icon: new Icon(Icons.clear, size: 20.0, color: Color(0xff666666)),
                onPressed: () => print(1),
              ),
            ),
            new Offstage(
              offstage: false,
              child: new IconButton(
                icon: new Icon(Icons.remove_red_eye, size: 20.0, color: Color(0xff666666)),
                onPressed: () => print(1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 输入
  Widget _widgetInputSection1 () {

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
            onTap: () => Application.router.push(context, 'register'),
            child: new Text(
              '点击注册',
              style: TextStyle(color: Application.config.style.mainColor),
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
        color: Application.config.style.mainColor,
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
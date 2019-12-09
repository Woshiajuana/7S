
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/model.dart';
import 'dart:convert';

class LoginView extends StatefulWidget {

  @override
  _LoginViewState createState() => new _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  String _strAccount;
  String _strPassword;
  String _strCaptcha;
  bool _isPwdObscure = true;
  TextEditingController _accountController;
  TextEditingController _passController;
  TextEditingController _captchaController;
  String _strCaptchaBase64;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _strAccount = '979703986@qq.com';
    _strPassword = '1';
    _accountController = TextEditingController(text: _strAccount);
    _passController = TextEditingController(text: _strPassword);
    _captchaController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _accountController.dispose();
    _passController.dispose();
    _captchaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
//      resizeToAvoidBottomPadding: false,
      body: new Container(
        decoration: new BoxDecoration(
          color: Colors.blue,
          image: new DecorationImage(
            image: new AssetImage(Application.util.getImgPath('login_bg.jpg')),
            fit: BoxFit.cover,
          ),
        ),
        child: new Container(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          child: new ListView(
            padding: const EdgeInsets.all(0),
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height,
                child: new Column(
                  children: <Widget>[
                    _widgetHeaderSection(),
                    new SizedBox(height: 55.0),
                    _widgetInputSection(
                      controller: _accountController,
                      icon: new Image.asset(Application.util.getImgPath('user_icon.png'), width: 16.0, height: 16.0),
                      hintText: '账号',
                      value: _strAccount,
                      onChanged: (value) => setState(() => _strAccount = value),
                      onClear: () { _accountController.clear(); setState(() => _strAccount = ''); },
                      onEye: () => {},
                    ),
                    _widgetInputSection(
                      controller: _passController,
                      icon: new Image.asset(Application.util.getImgPath('pwd_icon.png'), width: 20.0, height: 21.0),
                      hintText: '密码',
                      isObscure: _isPwdObscure,
                      useEye: true,
                      value: _strPassword,
                      onChanged: (value) => setState(() => _strPassword = value),
                      onClear: () { _passController.clear(); setState(() => _strPassword = ''); },
                      onEye: () => setState(() => _isPwdObscure = !_isPwdObscure),
                    ),
                    _strCaptchaBase64 == null
                        ? new Container()
                        : _widgetInputSection(
                      controller: _captchaController,
                      icon: new Image.asset(Application.util.getImgPath('code_icon.png'), width: 16.0, height: 16.0),
                      hintText: '验证码',
                      value: _strCaptcha,
                      onChanged: (value) => setState(() => _strCaptcha = value),
                      onClear: () { _captchaController.clear(); setState(() => _strCaptcha = ''); },
                      onEye: () => {},
                      captcha: _widgetCodeCell(),
                    ),
                    _widgetButtonSection(),
                    _widgetForgetSection(),
                    new Expanded(child: new Container(), flex: 1),
                    _widgetRegisterLinkSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 验证码
  Widget _widgetCodeCell () {
    return new Container(
      width: 80.0,
      height: 30.0,
      margin: const EdgeInsets.only(right: 16.0),
      padding: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border.all(
          color: Color(0xff999999),
          width: 0.5,
        ),
      ),
      child: new InkWell(
        onTap: () => _handleResetCaptcha(),
        child: new Image.memory(
          base64.decode(_strCaptchaBase64),
          height: 30,    //设置高度
          width: 70,    //设置宽度
          fit: BoxFit.fill,    //填充
          gaplessPlayback:true,
        ),
      ),
    );
  }

  // 头部 LOGO
  Widget _widgetHeaderSection () {
    return new Container(
      margin: const EdgeInsets.only(top: 90.0),
      child: new Image.asset(
        Application.util.getImgPath('login_logo.png'),
        width: 67.0,
        height: 115.0,
      ),
    );
  }

  // 输入框
  Widget _widgetInputSection ({
    TextEditingController controller,
    Widget icon,
    String hintText = '',
    bool isObscure = false,
    String value = '',
    bool useEye = false,
    Widget captcha,
    dynamic onChanged,
    dynamic onClear,
    dynamic onEye,
  }) {
    return new Center(
      child: new Container(
        width: 280.0,
        height: 46.0,
        margin: EdgeInsets.only(bottom: 10.0),
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
              child: icon,
            ),
            new Expanded(
              flex: 1,
              child: new TextField(
                controller: controller,
                obscureText: isObscure,
                decoration: new InputDecoration(
                  hintText: hintText,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: onChanged,
              ),
            ),
            new Offstage(
              offstage: (value == '' || value == null),
              child: new IconButton(
                icon: new Icon(Icons.clear, size: 20.0, color: Color(0xff666666)),
                onPressed: onClear,
              ),
            ),
            useEye ? new IconButton(
              icon: new Icon(Icons.remove_red_eye, size: 20.0, color: isObscure ? Color(0xff666666) : Application.config.style.mainColor),
              onPressed: onEye,
            ) : new Container(),
            captcha ?? new Container()
          ],
        ),
      ),
    );
  }

  // 忘记密码
  Widget _widgetForgetSection () {
    return new Center(
      child: new Container(
        width: 280.0,
        margin: const EdgeInsets.only(top: 20.0),
        alignment: Alignment.centerRight,
        child: new InkWell(
          onTap: () => Application.router.push(context, 'passwordReset', params: { 'email': _strAccount }),
          child: new Text(
            '忘记密码？',
            style: new TextStyle(
              fontSize: 14.0,
              color: Color(0xffdddddd),
            ),
          ),
        ),
      ),
    );
  }

  // 注册
  Widget _widgetRegisterLinkSection () {
    return new Container(
      margin: const EdgeInsets.only(bottom: 40.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            '没有账号？ ',
            style: TextStyle(color: Colors.white),
          ),
          new InkWell(
            onTap: () => Application.router.push(context, 'register', params: { 'email': _strAccount }),
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
    return new Center(
      child: new Container(
        width: 280.0,
        height: 46.0,
        decoration: new BoxDecoration(
          color: Application.config.style.mainColor,
          borderRadius: new BorderRadius.circular(30.0),
        ),
        child: new FlatButton(
          onPressed: () => _handleSubmit(),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                '登录',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 重置图形验证码
  void _handleResetCaptcha () async {
    try {
      if (_strAccount == null || _strAccount == '')
        throw '逗我呢？得输入账号呀';
      Application.util.loading.show(context);
      String strUrl = Application.config.api.doUserResetCaptcha;
      Map<String, String> mapParams = { 'account': _strAccount };
      var data = await Application.util.http.post(strUrl, params: mapParams);
      setState(() => _strCaptchaBase64 = data);
    } catch (err) {
      Application.util.modal.toast(err);
    } finally {
      Application.util.loading.hide();
    }
  }

  // 提交
  void _handleSubmit() async {
    try {
      if (_strAccount == null || _strAccount == '')
        throw '逗我呢？得输入账号呀';
      if (_strPassword == null || _strPassword == '')
        throw '唬谁呢？密码都没输入';
      if (_strCaptchaBase64 != null && (_strCaptcha == null || _strCaptcha == ''))
        throw '你验证码倒是填写下呀';
      String strUrl = Application.config.api.doUserLogin;
      Map<String, String> mapParams = {
        'account': _strAccount,
        'password': _strPassword,
        'captcha': _strCaptcha,
      };
      ResponseJsonModel responseJsonModel = await Application.util.http.post(strUrl, params: mapParams, useFilter: false);
      if (responseJsonModel.code == 'F50001') {
        setState(() => _strCaptchaBase64 = responseJsonModel.data);
      }
      if (Application.config.env.arrSucCode.indexOf(responseJsonModel.code) == -1) {
        throw responseJsonModel.msg;
      }
      await Application.util.store.set(Application.config.store.userJson, responseJsonModel.data);
      UserJsonModel userJsonModel = UserJsonModel.fromJson(responseJsonModel.data);
      StateModel.of(context).setUserJsonModel(userJsonModel);
      await Application.util.store.set(Application.config.store.accessToken, userJsonModel.accessToken);
      Application.router.replace(context, 'app');
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }
}
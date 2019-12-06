
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accountController = TextEditingController(text: '');
    _passController = TextEditingController(text: '');
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
                new SizedBox(height: 10.0),
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
                new SizedBox(height: 10.0),
                _widgetInputSection(
                  controller: _captchaController,
                  icon: new Image.asset(Application.util.getImgPath('code_icon.png'), width: 16.0, height: 16.0),
                  hintText: '验证码',
                  value: _strCaptcha,
                  onChanged: (value) => setState(() => _strCaptcha = value),
                  onClear: () { _captchaController.clear(); setState(() => _strCaptcha = ''); },
                  onEye: () => {},
                ),
                new SizedBox(height: 10.0),
                _widgetButtonSection(),
                new SizedBox(height: 20.0),
                _widgetForgetSection(),
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
  Widget _widgetInputSection ({
    TextEditingController controller,
    Widget icon,
    String hintText = '',
    bool isObscure = false,
    String value = '',
    bool useEye = false,
    dynamic onChanged,
    dynamic onClear,
    dynamic onEye,
  }) {
    return new Center(
      child: new Container(
        width: 280.0,
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
        alignment: Alignment.centerRight,
        child: new InkWell(
          onTap: () => Application.router.push(context, 'passwordReset'),
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
    return new Positioned(
      bottom: 30.0,
      left: 0,
      right: 0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            '没有账号？ ',
            style: TextStyle(color: Colors.white),
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

  // 提交
  void _handleSubmit() async {
    try {
      if (_strAccount == null || _strAccount == '')
        throw '逗我呢？得输入账号呀';
      if (_strPassword == null || _strPassword == '')
        throw '唬谁呢？密码都没输入';
      Application.util.loading.show(context);
      String strUrl = Application.config.api.doUserLogin;
      Map<String, String> mapParams = { 'account': _strAccount, 'password': _strPassword };
      var respBody = await Application.util.http.post(strUrl, params: mapParams);
      print('respBody => $respBody');
    } catch (err) {
      Application.util.modal.toast(err);
    } finally {
      Application.util.loading.hide();
    }

//    Application.router.replace(context, 'app');
  }
}
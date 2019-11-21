
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
  bool _isPwdObscure = true;
  int _numDefCount = 10;
  int _numCount = 10;
  TimerUtil _timerUtil;


  TextEditingController _emailController;
  TextEditingController _codeController;
  TextEditingController _passController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController(text: '');
    _codeController = TextEditingController(text: '');
    _passController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passController.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); // 记得中dispose里面把timer cancel。
    super.dispose();
  }

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
            new ListView(
              children: <Widget>[
                new SizedBox(height: 10.0),
                _widgetInputSection(
                  controller: _emailController,
                  hintText: '邮箱',
                  value: _strEmail,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => setState(() => _strEmail = value),
                  onClear: () { _emailController.clear(); setState(() => _strEmail = ''); },
                  onEye: () => {},
                ),
                new SizedBox(height: 10.0),
                _widgetInputSection(
                  controller: _codeController,
                  hintText: '验证码',
                  value: _strCode,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => setState(() => _strCode = value),
                  onClear: () { _codeController.clear(); setState(() => _strCode = ''); },
                  onEye: () => {},
                ),
                new SizedBox(height: 10.0),
                _widgetInputSection(
                  controller: _passController,
                  hintText: '密码',
                  isObscure: _isPwdObscure,
                  useEye: true,
                  value: _strPassword,
                  onChanged: (value) => setState(() => _strPassword = value),
                  onClear: () { _passController.clear(); setState(() => _strPassword = ''); },
                  onEye: () => setState(() => _isPwdObscure = !_isPwdObscure),
                ),
                new SizedBox(height: 16.0),
                _widgetAgreementSection(),
                new SizedBox(height: 60.0),
                _widgetButtonSection(),
              ],
            )
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

  // input
  Widget _widgetInputSection ({
    TextEditingController controller,
    Widget child,
    String hintText = '',
    bool isObscure = false,
    String value = '',
    bool useEye = false,
    TextInputType keyboardType,
    dynamic onChanged,
    dynamic onClear,
    dynamic onEye,
  }) {
    return new Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            color: Color(0xffcccccc),
            width: 0.5,
          ),
        ),
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new TextField(
              controller: controller,
              obscureText: isObscure,
              keyboardType: keyboardType,
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
          child ?? new Container(),
        ],
      ),
    );
  }

  // 发送验证码
  Widget _widgetCodeSection () {
    return new Container();
  }

  // 协议
  Widget _widgetAgreementSection () {
    return new Container(
      margin: const EdgeInsets.only(left: 1.0, right: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Checkbox(
            value: false,
            activeColor: Application.config.style.mainColor,
            onChanged: (bool val) {},
          ),
          new Text(
            '我已阅读并同意 ',
            style: TextStyle(color: Color(0xff999999)),
          ),
          new InkWell(
            onTap: () => Application.router.push(context, 'webview', params: { 'title': '用户协议', 'url': 'https://www.baidu.com' }),
            child: new Text(
              '用户协议',
              style: TextStyle(color: Application.config.style.mainColor),
            ),
          ),
          new Text(
            ' 和 ',
            style: TextStyle(color: Color(0xff999999)),
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
                '注册',
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

}


import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';
import 'package:qimiao/model/model.dart';

class PasswordChangeView extends StatefulWidget {
  @override
  _PasswordChangeViewState createState() => _PasswordChangeViewState();
}

class _PasswordChangeViewState extends State<PasswordChangeView> {

  String _strEmail; // 邮箱
  String _strPassword; // 密码
  String _strOldPassword; // 验证码
  bool _isPwdObscure = true;
  bool _isOldPwdObscure = true;

  TextEditingController _emailController;
  TextEditingController _oldPwdController;
  TextEditingController _passController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController(text: '');
    _oldPwdController = TextEditingController(text: '');
    _passController = TextEditingController(text: '');
    this._reqUserInfo();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _oldPwdController.dispose();
    _passController.dispose();
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
          '修改密码',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new Container(
            width: 70.0,
            child: new FlatButton(
              onPressed: () => _handleSubmit(),
              padding: const EdgeInsets.all(0),
              child: new Text(
                '确认',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new SizedBox(height: 10.0),
          _widgetInputSection(
            controller: _emailController,
            hintText: '邮箱',
            value: _strEmail,
            isEnabled: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => setState(() => _strEmail = value),
            onClear: () { _emailController.clear(); setState(() => _strEmail = ''); },
            onEye: () => {},
          ),
          new SizedBox(height: 10.0),
          _widgetInputSection(
            controller: _oldPwdController,
            hintText: '旧密码',
            isObscure: _isOldPwdObscure,
            useEye: true,
            value: _strOldPassword,
            onChanged: (value) => setState(() => _strOldPassword = value),
            onClear: () { _oldPwdController.clear(); setState(() => _strOldPassword = ''); },
            onEye: () => setState(() => _isOldPwdObscure = !_isOldPwdObscure),
          ),
          new SizedBox(height: 10.0),
          _widgetInputSection(
            controller: _passController,
            hintText: '新密码',
            isObscure: _isPwdObscure,
            useEye: true,
            value: _strPassword,
            onChanged: (value) => setState(() => _strPassword = value),
            onClear: () { _passController.clear(); setState(() => _strPassword = ''); },
            onEye: () => setState(() => _isPwdObscure = !_isPwdObscure),
          ),
          new SizedBox(height: 60.0),
        ],
      ),
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
    bool isEnabled = true,
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
              enabled: isEnabled,
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
          isEnabled ? new Offstage(
            offstage: (value == '' || value == null),
            child: new IconButton(
              icon: new Icon(Icons.clear, size: 20.0, color: Color(0xff666666)),
              onPressed: onClear,
            ),
          ) : new Container(),
          useEye ? new IconButton(
            icon: new Icon(Icons.remove_red_eye, size: 20.0, color: isObscure ? Color(0xff666666) : Application.config.style.mainColor),
            onPressed: onEye,
          ) : new Container(),
          child ?? new Container(),
        ],
      ),
    );
  }

  // 获取用户信息
  void _reqUserInfo () async {
    try {
      Future.delayed(Duration(milliseconds: 0)).then((e) async{
        UserJsonModel userJsonModel = StateModel.of(context).user;
        setState(() {
          _strEmail = userJsonModel.email;
          _emailController.text = _strEmail;
        });
      });
    } catch (err) {
      Application.util.modal.toast(err);
    }
  }

  // 提交
  void _handleSubmit() async {
    if (_strPassword == null || _strPassword == '')
      throw '以旧换新，旧密码呢？';
    if (_strOldPassword == null || _strOldPassword == '')
      throw '新密码你不设置呀？';
    String strUrl = Application.config.api.doUserChangePassword;
    Map<String, String> mapParams = {
      'password': _strPassword,
      'oldPassword': _strOldPassword,
    };
    await Application.util.http.post(strUrl, params: mapParams);
    Application.util.modal.toast('修改成功');
    Application.router.pop(context);
  }

}

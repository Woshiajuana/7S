
import 'package:flutter/material.dart';

class InputGroup extends StatefulWidget {

  const InputGroup({
    Key key,
    this.usernameChange = '',
    this.passwordChange = '',
    this.username = '',
    this.password = '',
  }) : super(key: key);

  final usernameChange;
  final passwordChange;
  final String username;
  final String password;

  @override
  _InputGroupState createState() => new _InputGroupState();
}

class _InputGroupState extends State<InputGroup> {

  // 手机号的控制器
  TextEditingController phoneController;
  //密码的控制器
  TextEditingController passController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneController = TextEditingController(text: widget.username);
    passController = TextEditingController(text: widget.password);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    phoneController.dispose();
    passController.dispose();
    phoneController = null;
    passController = null;
    super.dispose();
  }

  void _onChange (String value, String key) {
    key == 'password' ? widget.passwordChange('$value') : widget.usernameChange('$value');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 32.0),
      child: new Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: new TextField(
              controller: phoneController,
              maxLength: 11,
              keyboardType: TextInputType.number,
              onChanged: (value) => _onChange(value, 'username'),
              decoration: new InputDecoration(
                labelText: '账号',
              ),
            ),
          ),

          new Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: new TextField(
              obscureText: true,
              controller: passController,
              maxLength: 20,
              onChanged: (value) => _onChange(value, 'password'),
              decoration: new InputDecoration(
                labelText: '密码',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
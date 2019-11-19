
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:qimiao/view//login/components/headerGroup.dart';
import 'package:qimiao/view/login/components/inputGroup.dart';
import 'package:qimiao/view/login/components/buttonGroup.dart';

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
      body: new ListView(
        children: <Widget>[
          new HeaderGroup(),
          new InputGroup(
            username: _username,
            password: _password,
            usernameChange: (value) => this.setState(() => _username = value),
            passwordChange: (value) => this.setState(() => _password = value),
          ),
          new ButtonGroup(
            onTap: () => _handleSubmit(),
          ),
        ],
      ),
    );
  }

  // 提交
  void _handleSubmit() async {

  }
}
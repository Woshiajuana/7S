
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class MineNicknameView extends StatefulWidget {
  @override
  _MineNicknameViewState createState() => _MineNicknameViewState();
}

class _MineNicknameViewState extends State<MineNicknameView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '修改昵称',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.info),
            onPressed: () => {},
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[

        ],
      ),
    );
  }

  // 输入框


}

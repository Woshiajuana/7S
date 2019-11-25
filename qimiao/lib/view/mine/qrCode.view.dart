
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class MineQrCodeView extends StatefulWidget {
  @override
  _MineQrCodeViewState createState() => _MineQrCodeViewState();
}

class _MineQrCodeViewState extends State<MineQrCodeView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '二维码名片',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: <Widget>[
          new Container(
            width: 70.0,
            child: new FlatButton(
              onPressed: () => {},
              padding: const EdgeInsets.all(0),
              child: new Text(
                '分享',
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
      body: new Container(
        alignment: Alignment.center,
        child: new Container(
          width: 300.0,
          height: 300.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(10.0),
            border: new Border.all(color: Color(0xffdddddd), width: 0.5),
          ),
        ),
      ),
    );
  }
}

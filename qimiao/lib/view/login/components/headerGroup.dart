
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class HeaderGroup extends StatefulWidget {
  
  @override
  _HeaderGroupState createState() => new _HeaderGroupState();
}

class _HeaderGroupState extends State<HeaderGroup> {
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: const EdgeInsets.only(top: 60.0, left: 20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Image.asset(
              Application.config.style.srcLogo,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.fill,
              color: Colors.blue,
            ),
          ),
          new Text(
            '您好，',
            style: new TextStyle(
              fontSize: 28.0,
              color: Color(0xff333333),
            ),
          ),
          new Text(
            '欢迎使用哇噻商城，请先登录，',
            style: new TextStyle(
              fontSize: 16.0,
              color: Color(0xff333333),
            ),
          ),
        ],
      ),
    );
  }
}
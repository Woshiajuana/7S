
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class DeviceView extends StatefulWidget {
  @override
  _DeviceViewState createState() => _DeviceViewState();
}

class _DeviceViewState extends State<DeviceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '登录设备管理',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          _widgetDeviceItem(),
          _widgetDeviceItem(),
          _widgetDeviceItem(),
          _widgetDeviceItem(),
        ],
      ),
    );
  }

  // 消息
  Widget _widgetDeviceItem () {
    return new Container(
      height: 70,
      padding: const EdgeInsets.only(left: 16.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
            bottom: new BorderSide(
              color: Color(0xffdddddd),
              width: 0.5,
            )
        ),
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                '2019/09/09 10:10:10',
                style: new TextStyle(
                  color: Color(0xff999999),
                  fontSize: 12.0,
                ),
              ),
              new Text(
                '实名认证',
                style: new TextStyle(
                  color: Color(0xff666666),
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          new IconButton(
            icon: new Icon(Icons.delete, size: 18.0, color: Colors.red),
            onPressed: () => { },
          ),
        ],
      ),
    );
  }
}

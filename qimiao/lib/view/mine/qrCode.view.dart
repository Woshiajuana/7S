
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
          height: 360.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(10.0),
            border: new Border.all(color: Color(0xffdddddd), width: 0.5),
          ),
          child: new Column(
            children: <Widget>[
              _widgetUserSection(),
              _widgetQrCodeSection(),
            ],
          ),
        ),
      ),
    );
  }

  // 用户信息
  Widget _widgetUserSection () {
    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: new Row(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              border: new Border.all(color: Color(0xFF9E9E9E), width: 0.5), // 边色与边宽度
              color: Color(0xFF9E9E9E), // 底色
              borderRadius: new BorderRadius.circular((41)), // 圆角度
            ),
            child: new ClipOval(
              child: new FadeInImage.assetNetwork(
                width: 48.0,
                height: 48.0,
                placeholder: Application.config.style.srcGoodsNull,
                image: 'https://h5-mk.oss-cn-shanghai.aliyuncs.com/qimiao/5de76b48169de6de69e24c54/AVATAR/20191205174002.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          new SizedBox(width: 10.0),
          new Expanded(
            flex: 1,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  '我是阿倦啊',
                  style: new TextStyle(
                    color: Color(0xff666666),
                    fontSize: 18.0,
                  ),
                ),
                new SizedBox(height: 3.0),
                new Text(
                  '7S-ID:0000001',
                  style: new TextStyle(
                    color: Color(0xff666666),
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 用户二维码
  Widget _widgetQrCodeSection () {
    return new Expanded(
      flex: 1,
      child: new Center(
        child: new Container(
          color: Color(0xFF9E9E9E),
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }
}

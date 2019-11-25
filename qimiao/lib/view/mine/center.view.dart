
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class MineCenterView extends StatefulWidget {
  @override
  _MineCenterViewState createState() => _MineCenterViewState();
}

class _MineCenterViewState extends State<MineCenterView> {

  @override
  Widget build(BuildContext context) {

    List _arrData = [
      {
        'onPressed': () => {},
        'labelText': '头像',
        'useMargin': true,
        'height': 100.0,
        'child': new Container(
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.white, width: 2.0), // 边色与边宽度
            color: Color(0xFF9E9E9E), // 底色
            borderRadius: new BorderRadius.circular((41)), // 圆角度
          ),
          child: new ClipOval(
            child: new FadeInImage.assetNetwork(
              width: 80.0,
              height: 80.0,
              placeholder: Application.config.style.srcGoodsNull,
              image: 'http://ossmk2.jfpays.com/www_make_v1/app/static/images/defaultFace013x.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      },
      {
        'onPressed': () => {},
        'labelText': '昵称',
        'valueText': '右边',
      },
      {
        'onPressed': () => {},
        'labelText': '7S-ID',
        'valueText': '右边',
      },
      {
        'onPressed': () => {},
        'labelText': '二维码',
        'valueText': '右边',

      },
    ];

    return new Scaffold(
      backgroundColor: Application.config.style.backgroundColor,
      appBar: new AppBar(
        elevation: 0,
        title: new Text(
          '个人中心',
          style: new TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: new ListView(
        children: _arrData.map((item) => _widgetCellItem(
          onPressed: item['onPressed'],
          labelText: item['labelText'] ?? '',
          valueText: item['valueText'] ?? '',
          useMargin: item['useMargin'] ?? false,
          child: item['child'],
          height: item['height'] ?? 60.0,
        )).toList(),
      ),
    );
  }

  Widget _widgetCellItem ({
    dynamic onPressed,
    String labelText,
    String valueText,
    bool useMargin,
    Widget child,
    double height,
  }) {
    return new Container(
      height: height,
      margin: EdgeInsets.only(top: useMargin ? 10.0 : 0),
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          bottom: new BorderSide(
            color: Color(0xffdddddd),
            width: 0.5,
          ),
          top: new BorderSide(
            color: Color(0xffdddddd),
            width: useMargin ? 0.5 : 0,
          ),
        ),
      ),
      child: new FlatButton(
        onPressed: onPressed,
        child: new Row(
          children: <Widget>[
            new Text(
              labelText,
              style: new TextStyle(
                color: Color(0xff333333),
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            new Expanded(flex: 1, child: new Container()),
            child ?? new Text(
              valueText,
              style: new TextStyle(
                color: Color(0xff999999),
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            new SizedBox(width: 10.0),
            new Icon(Icons.arrow_forward_ios, size: 18.0, color: Color(0xff999999)),
          ],
        ),
      ),
    );
  }
}

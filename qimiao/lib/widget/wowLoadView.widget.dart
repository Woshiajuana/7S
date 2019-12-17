
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class WowLoadView extends StatelessWidget{

  const WowLoadView({
    Key key,
    this.status,
    this.data,
    @required this.child,
  }) : super (key: key);

  final Widget child;
  final dynamic status;
  final List data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        new Offstage(
          offstage: !((data == null && status == null) || status == true),
          child: new Container(
            alignment: Alignment.center,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 16.0,
                  height: 16.0,
                  margin: const EdgeInsets.only(right: 10.0),
                  child: new CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
                new Text(
                  '拼命加载中...',
                  style: new TextStyle(
                    color: Color(0xff999999),
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        new Offstage(
          offstage: !(data != null && data.length == 0),
          child: new Container(
            alignment: Alignment.center,
            child: new Column(
              children: <Widget>[
                new SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                new Image.asset(
                  Application.util.getImgPath('null_bg.png'),
                  width: 100,
                  fit: BoxFit.cover,
                ),
                new SizedBox(height: 20.0),
                new Text(
                  '哦豁...暂无数据',
                  style: new TextStyle(
                    color: Color(0xff999999),
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        new Offstage(
          offstage: !(data != null || status == false),
          child: child,
        ),
//        (data != null || status == false) ? child : new Container(),
      ],
    );
  }
}
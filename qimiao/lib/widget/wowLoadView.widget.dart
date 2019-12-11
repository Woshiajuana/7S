
import 'package:flutter/material.dart';

class WowLoadView extends StatelessWidget{

  const WowLoadView({
    Key key,
    this.status,
    @required this.child,
  }) : super (key: key);

  final Widget child;
  final dynamic status;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        new Offstage(
          offstage: false,
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
                    color: Colors.blue,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        new Offstage(
          offstage: false,
          child: child,
        )
      ],
//
//
//        isLoading == null ? new Container() : this.child,
//        isLoading != false ? new Container(
//          child: new Center(
//            child: new Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                new Container(
//                  width: 20.0,
//                  height: 20.0,
//                  margin: const EdgeInsets.only(right: 10.0),
//                  child: new CircularProgressIndicator(
//                    strokeWidth: 2.0,
//                  ),
//                ),
//                new Text(
//                  '加载中...',
//                  style: new TextStyle(
//                    color: Colors.blue,
//                    fontSize: 12.0,
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ) : new Container(),
//      ],
    );
  }
}
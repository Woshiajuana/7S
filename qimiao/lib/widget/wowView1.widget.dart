
import 'package:flutter/material.dart';

class WowView extends StatelessWidget{

  const WowView({
    Key key,
    this.isLoading = false,
    this.child,
  }) : super (key: key);

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        isLoading == null ? new Container() : this.child,
        isLoading != false ? new Container(
          child: new Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  width: 20.0,
                  height: 20.0,
                  margin: const EdgeInsets.only(right: 10.0),
                  child: new CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
                new Text(
                  '加载中...',
                  style: new TextStyle(
                    color: Colors.blue,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ) : new Container(),
      ],
    );
  }
}
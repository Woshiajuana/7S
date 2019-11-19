
import 'package:flutter/material.dart';

class ButtonGroup extends StatefulWidget {

  ButtonGroup({
    Key key,
    this.onTap,
  }) : super(key: key);

  final onTap;

  @override
  _ButtonGroupState createState() => new _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      height: 45.0,
      margin: const EdgeInsets.only(left: 60.0, right: 60.0, top: 60.0),
      decoration: new BoxDecoration(
        color: Colors.blue,
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: new InkWell(
        onTap: () => widget.onTap(),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              '登录',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
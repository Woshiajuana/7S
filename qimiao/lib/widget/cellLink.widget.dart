
import 'package:flutter/material.dart';

class CellLinkWidget extends StatelessWidget {

  const CellLinkWidget({
    Key key,
    this.onPressed,
    this.labelText = '',
    this.valueText = '',
    this.bottomBorder = 0.5,
    this.topBorder = 0,
  }) : super(key: key);

  final dynamic onPressed;
  final String labelText;
  final double topBorder;
  final double bottomBorder;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 50.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          top: new BorderSide(
            color: Color(0xffdddddd),
            width: topBorder,
          ),
          bottom: new BorderSide(
            color: Color(0xffdddddd),
            width: bottomBorder,
          ),
        ),
      ),
      child: new FlatButton(
        onPressed: onPressed,
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Row(
          children: <Widget>[
            new Text(
              labelText ?? '',
              style: new TextStyle(
                color: Color(0xff666666),
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            new Expanded(child: new Container(), flex: 1),
            new Text(
              valueText ?? '',
              style: new TextStyle(
                color: Color(0xff666666),
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed == null ? new Container() : new Icon(Icons.arrow_forward_ios, size: 16.0, color: Color(0xff666666),),
          ],
        ),
      ),
    );
  }
}

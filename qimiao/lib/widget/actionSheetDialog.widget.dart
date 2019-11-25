
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class ActionSheetDialog extends StatefulWidget {

  const ActionSheetDialog({
    Key key,
    this.arrContent,
  }) : super(key: key);

  final List<String> arrContent;

  @override
  _ActionSheetDialogState createState() => _ActionSheetDialogState();
}

class _ActionSheetDialogState extends State<ActionSheetDialog> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Column(
        children: <Widget>[
          new Container(
            height: 50.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: new FlatButton(
              onPressed: () => {},
              child: new Text(
                '取消',
                style: new TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  color: Color(0xff999999),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}

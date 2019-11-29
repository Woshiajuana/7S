
import 'package:flutter/material.dart';
import 'package:qimiao/common/application.dart';

class AlertToastDialog extends StatefulWidget {

  const AlertToastDialog({Key key, this.content}) : super(key: key);

  final String content;

  @override
  _AlertToastDialogState createState() => _AlertToastDialogState();
}

class _AlertToastDialogState extends State<AlertToastDialog> {
  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            width: 300.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: new Column(
              children: <Widget>[
                _widgetContentSection(),
                _widgetButtonSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 内容
  Widget _widgetContentSection () {
    return new Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
      child: new Text(
        widget.content,
        style: new TextStyle(
          color: Color(0xff2d2a34),
          fontSize: 16.0,
        ),
      ),
    );
  }

  // 按钮
  Widget _widgetButtonSection () {
    return new Container(
      height: 50,
      width: double.infinity,
      child: new FlatButton(
        onPressed: () => Navigator.of(context).pop(),
        child: new Text(
          '我知道了',
          style: new TextStyle(
            color: Application.config.style.mainColor,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
